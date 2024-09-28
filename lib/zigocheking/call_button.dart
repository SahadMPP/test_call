import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ZegoSendCallInvitationButton(invitees: [
          ZegoUIKitUser(id: '1', name: 'One'),
        ], isVideoCall: false),
      ),
    );
  }
}