// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:call_tester/zigocheking/call_button.dart';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class HomeScreenZigo extends StatefulWidget {
  const HomeScreenZigo({super.key});

  @override
  State<HomeScreenZigo> createState() => _HomeScreenZigoState();
}

class _HomeScreenZigoState extends State<HomeScreenZigo> {
  TextEditingController userIdCon = TextEditingController();
  TextEditingController userNameCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userIdCon,
              ),
              TextField(
                controller: userNameCon,
              ),
              ElevatedButton(
                  onPressed: ()  {
                    ZegoUIKitPrebuiltCallInvitationService().init(
                      appID: 1047661351,
                      appSign:
                          'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c',
                      userID: userIdCon.text,
                      userName: userNameCon.text,
                      plugins: [ZegoUIKitSignalingPlugin()],
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const CallButton()),
                    );
                  },
                  child: const Text('input')),
            ],
          ),
        ),
      ),
    );
  }
}
