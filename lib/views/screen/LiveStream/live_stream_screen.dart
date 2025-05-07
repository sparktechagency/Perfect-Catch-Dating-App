import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
import 'package:perfect_catch_dating_app/helpers/route.dart';
import 'package:perfect_catch_dating_app/service/api_client.dart';
import 'package:perfect_catch_dating_app/service/api_constants.dart';
import 'package:perfect_catch_dating_app/utils/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../base/bottom_menu..dart';
const appId = "1e699e1a1aa34149b92e62c83ff3bd22";

class LiveStreamController extends GetxController{
  RxBool isAgoraInitialized = false.obs;
  RxBool isLiveStreamingLoading = false.obs;
  RxString agoraToken = ''.obs;
  RxString agoraTChannelName = ''.obs;

  Future<bool> getLiveStreamingProfile({required String uuid}) async{
    isLiveStreamingLoading.value = true;
    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await ApiClient.getData(
        ApiConstants.getLiveStreamEndPoint(uuid),
        headers: headers
    );


    if(response.statusCode == 200 || response.statusCode == 201){
      isLiveStreamingLoading.value = false;
      agoraToken.value = response.body['data']['attributes']['token'];
      agoraTChannelName.value = response.body['data']['attributes']['channelName'];
      return true;
    }
    isLiveStreamingLoading.value = false;
    return false;
  }

}

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({super.key});

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {

  final LiveStreamController liveStreamController = Get.put(LiveStreamController());
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _speakerOn = true;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }
  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print("onJoinChannelSuccess : $connection");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          print("onUserJoined : $connection");

          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          print("onUserOffline : $connection");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    bool result = await liveStreamController.getLiveStreamingProfile(uuid: "0");
    if(result){
      await _engine.joinChannel(
        token: liveStreamController.agoraToken.value,
        // channelId: liveStreamController.agoraTChannelName.value,
        // token: "007eJxTYFD0fj3VYdfJOUnfGG/N6T2sNOvvj2KHzdtnuccYrFyaIN2pwGCYamZpmWqYaJiYaGxiaGKZZGmUamaUbGGclmaclGJkxCEundEQyMgwa6cpIyMDBIL4LAwhqcUlDAwAmeQfbQ==",
        channelId: "Test",
        uid: 0,
        options: const ChannelMediaOptions(),
      );
      liveStreamController.isAgoraInitialized.value = true;
    }

  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _toggleMute() {
    setState(() => _muted = !_muted);
    _engine.muteLocalAudioStream(_muted);
  }

  void _toggleSpeaker() {
    setState(() => _speakerOn = !_speakerOn);
    _engine.setEnableSpeakerphone(_speakerOn);
  }

  void _switchCamera() {
    _engine.switchCamera();
  }

  void _endCall() async{
    await _engine.leaveChannel();
    await _engine.release();
    Get.toNamed(AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(2),
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!liveStreamController.isAgoraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: Center(
                child: _remoteVideo(channelId: "Test"),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  _localUserJoined
                      ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                      : const Center(child: CircularProgressIndicator()),

                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: _endCall,
                          icon: const Icon(Icons.cancel, color: Colors.red, size: 48),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.white,
  }) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.grey.shade800,
      child: IconButton(
        icon: Icon(icon, color: color, size: 28),
        onPressed: onTap,
      ),
    );
  }

  Widget _remoteVideo({required String channelId}) {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channelId),
        ),
      );
    } else {
      return const Text(
        'Waiting for remote user to join...',
        style: TextStyle(color: Colors.white, fontSize: 16),
        textAlign: TextAlign.center,
      );
    }
  }
}