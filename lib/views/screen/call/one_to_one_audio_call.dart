import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_catch_dating_app/controllers/call_controller.dart';
import 'package:permission_handler/permission_handler.dart';


class OneToOneAudioCall extends StatefulWidget {
  const OneToOneAudioCall({super.key});

  @override
  State<OneToOneAudioCall> createState() => _OneToOneAudioCallState();
}

const appId = "1e699e1a1aa34149b92e62c83ff3bd22";


class _OneToOneAudioCallState extends State<OneToOneAudioCall> {
  final CallController _callController = Get.put(CallController());

  int? _remoteUid;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _speakerOn = true;
  late RtcEngine _engine;
  final conversationId = Get.arguments["conversationId"];
  final receiverName =  Get.arguments["receiverName"];

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

    bool result = await _callController.getCallToken(type: "audio", receiverName: receiverName);
    if(result){
      await _engine.joinChannel(
        token: _callController.agoraToken.value,
        channelId: _callController.agoraTChannelName.value,
        // token: "007eJxTYLieHS0z/dZF8Tz28slPebarzFSsPZEzR6F4Yv/3tTfLpDIVGAxTzSwtUw0TDRMTjU0MTSyTLI1SzYySLYzT0oyTUoyMvpXJZjQEMjJcS93OwAiFID4rQ0ZqTk4+AwMAbIsgMA==",
        // channelId: "hello",
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );
      _callController.isAgoraInitialized.value = true;
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

  void _endCall() async{
    await _engine.leaveChannel();
    await _engine.release();
    Get.back();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_in_talk, color: Colors.white, size: 100),
                  const SizedBox(height: 20),
                  Text(
                    _remoteUid != null ? "Connected" : "Calling...",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
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
                    icon: _speakerOn ? Icons.volume_up : Icons.volume_off,
                    color: _speakerOn ? Colors.white : Colors.grey,
                    onTap: _toggleSpeaker,
                  ),
                ],
              ),
            )
          ],
        ),
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
}