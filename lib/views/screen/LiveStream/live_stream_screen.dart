import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/helpers/prefs_helpers.dart';
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
  RxBool isAutoScroll = false.obs;

  Future<bool> getLiveStreamingProfile({required String uuid}) async{
    isLiveStreamingLoading.value = true;
    isAutoScroll.value = true;
    Future.delayed(Duration(seconds: 3));
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
      isAutoScroll.value = false;
      agoraToken.value = response.body['data']['attributes']['token'];
      agoraTChannelName.value = response.body['data']['attributes']['channelName'];
      print("token : ${agoraToken.value}");
      print("token channel name: ${agoraTChannelName.value}");
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
          liveStreamController.isAutoScroll.value = false;
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          liveStreamController.isAutoScroll.value = true;
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
        channelId: liveStreamController.agoraTChannelName.value,
        // token: "007eJxTYGAuOH7Ls4NZiufM1h5GnfrtnMwxl00sJz1nCo6pn+Tu5q7AYJhqZmmZaphomJhobGJoYplkaZRqZpRsYZyWZpyUYmS0SEc6oyGQkWG23lcWRgYIBPFZGTJSc3LyGRgAQtEcCA==",
        // channelId: "hello",
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
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
    liveStreamController.isAutoScroll.value = true;
    await _engine.leaveChannel();
    await _engine.release();
    initAgora();
    // Get.toNamed(AppRoutes.homeScreen);
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
              child: liveStreamController.isAutoScroll.value ? Center(child: SlotAutoScroll()) : _remoteVideo(channelId: liveStreamController.agoraTChannelName.value),
              // child: _remoteVideo(channelId: "hello"),
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Waiting for remote user to join...',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }
}

class SlotAutoScroll extends StatefulWidget {
  const SlotAutoScroll({super.key});

  @override
  State<SlotAutoScroll> createState() => _SlotAutoScrollState();
}

class _SlotAutoScrollState extends State<SlotAutoScroll> {
  final LiveStreamController _liveStreamController = Get.find<LiveStreamController>();

  final images = [
    'assets/images/userImage1.png',
    'assets/images/userImage2.png',
    'assets/images/userImage3.png',
  ];

  final List<ScrollController> controllers =
  List.generate(3, (_) => ScrollController());
  final List<Timer?> timers = List.generate(3, (_) => null);
  final List<double> speeds = [2.5, 3.2, 4.0];

  final int itemCount = 9999; // simulate infinite

  @override
  void initState() {
    super.initState();

    // Start infinite scroll for all reels
    for (int i = 0; i < 3; i++) {
      _startReel(i);
    }

    // Listen to the external RxBool
    ever(_liveStreamController.isAutoScroll, (bool spinning) {
      if (!spinning) {
        _stopAllReels();
      }
    });
  }

  void _startReel(int index) {
    timers[index]?.cancel();
    timers[index] = Timer.periodic(const Duration(milliseconds: 16), (_) {
      if (!_liveStreamController.isAutoScroll.value) return;

      final controller = controllers[index];

      try {
        final newOffset = controller.offset + speeds[index];
        if (newOffset >= controller.position.maxScrollExtent - 100) {
          controller.jumpTo(0);
        } else {
          controller.jumpTo(newOffset);
        }
      } catch (_) {
        // Ignore if layout not ready
      }
    });
  }

  void _stopAllReels() {
    for (int i = 0; i < 3; i++) {
      timers[i]?.cancel();
      _alignReelToImage(i);
    }
  }

  void _alignReelToImage(int index) {
    final controller = controllers[index];

    if (!controller.hasClients) return; // <-- ✅ Prevent crash

    final offset = controller.offset;
    final alignedOffset = (offset / 100).round() * 100;

    controller.animateTo(
      alignedOffset.toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }


  Widget _buildReel(int index) {
    return Expanded(
      child: ListView.builder(
        controller: controllers[index],
        itemExtent: 100,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, i) {
          final image = images[i % images.length];
          return Center(
            child: Image.asset(image, width: 50, height: 50),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var t in timers) {
      t?.cancel();
    }
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: Get.width * 0.5,
      child: Row(
        children: List.generate(3, _buildReel),
      ),
    );
  }
}



