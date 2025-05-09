import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class OneToOneVideoCall extends StatefulWidget {
  const OneToOneVideoCall({super.key});

  @override
  State<OneToOneVideoCall> createState() => _OneToOneVideoCallState();
}

const appId = "1e699e1a1aa34149b92e62c83ff3bd22";


class _OneToOneVideoCallState extends State<OneToOneVideoCall> {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _speakerOn = true;
  late RtcEngine _engine;
  String conversationId = Get.arguments;

  @override
  void initState() {
    super.initState();
    initAgora();
  }
  Future<void> initAgora() async {
    await [Permission.microphone].request();

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

    // bool result = await liveStreamController.getLiveStreamingProfile(uuid: "0");
    // if(result){
    await _engine.joinChannel(
      // token: liveStreamController.agoraToken.value,
      // channelId: liveStreamController.agoraTChannelName.value,
      token: "007eJxTYLieHS0z/dZF8Tz28slPebarzFSsPZEzR6F4Yv/3tTfLpDIVGAxTzSwtUw0TDRMTjU0MTSyTLI1SzYySLYzT0oyTUoyMvpXJZjQEMjJcS93OwAiFID4rQ0ZqTk4+AwMAbIsgMA==",
      channelId: "hello",
      uid: 0,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );
    // liveStreamController.isAgoraInitialized.value = true;
    // }

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
    Get.back();
    // Get.toNamed(AppRoutes.homeScreen);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: _remoteVideo(channel: "hello")),
          Positioned(
            top: 40,
            left: 20,
            child: SizedBox(
              width: 120,
              height: 160,
              child: _localUserJoined
                  ? AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine,
                  canvas: const VideoCanvas(uid: 0),
                ),
              )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  icon: _muted ? Icons.mic_off : Icons.mic,
                  color: _muted ? Colors.red : Colors.white,
                  onTap: _toggleMute,
                ),
                _buildControlButton(
                  icon: Icons.call_end,
                  color: Colors.red,
                  onTap: _endCall,
                ),
                _buildControlButton(
                  icon: Icons.cameraswitch,
                  color: Colors.white,
                  onTap: _switchCamera,
                ),
                _buildControlButton(
                  icon: _speakerOn ? Icons.volume_up : Icons.volume_off,
                  color: _speakerOn ? Colors.white : Colors.grey,
                  onTap: _toggleSpeaker,
                ),
              ],
            ),
          )
        ],
      ),
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

  Widget _remoteVideo({required String channel}) {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channel),
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