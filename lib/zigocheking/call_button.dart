import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ZegoSendCallInvitationButton(invitees: [
          ZegoUIKitUser(id: '1', name: 'One'),
        ], isVideoCall: false),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            radius: 30,
          ),
          Text('Name'),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(Icons.music_note),
              ),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 15,
                child: Icon(Icons.call),
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(Icons.speaker),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
