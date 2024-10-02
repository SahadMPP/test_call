// import 'package:flutter/material.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
// import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
// import 'dart:developer';

// class CallControlPage extends StatefulWidget {
//   final String userId;
//   final String calleeId; // Add callee ID

//   const CallControlPage({required this.userId, required this.calleeId});

//   @override
//   _CallControlPageState createState() => _CallControlPageState();
// }

// class _CallControlPageState extends State<CallControlPage> {
//   final String roomID = "room1"; // Can be dynamic as needed
//   bool isInRoom = false;
//   bool isPublishing = false;
//   bool isPlaying = false;
//   bool isSpeakerEnabled = true; // For controlling the speaker
//   int textureID = 0; // To hold the texture ID for the canvas view

//   @override
//   void initState() {
//     super.initState();
//     createEngine();
//     initSignaling(); // Initialize signaling when the page is loaded
//   }

//   Future<void> createEngine() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
//       1047661351, // Replace with your actual AppID
//       ZegoScenario.StandardVoiceCall,
//       appSign: 'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c', // Replace with your actual AppSign
//     ));
//     log('Zego Engine created');

//     // Create the canvas view
//     await ZegoExpressEngine.instance.createCanvasView((int createdTextureID) {
//       setState(() {
//         textureID = createdTextureID;
//       });
//       log('Canvas view created with texture ID: $textureID');
//     });
//   }

// Future<void> initSignaling() async {
//   // Initialize ZegoUIKitPrebuiltCallInvitationService
//   ZegoUIKitPrebuiltCallInvitationService().init(
//     appID: 1047661351, // Your App ID
//     appSign: 'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c', // Your App Sign
//     userID: widget.userId, // The current user ID
//     userName: widget.userId, // The current user name (use appropriate user name)
//     plugins: [ZegoUIKitSignalingPlugin()], // Pass the signaling plugin here
//   );

//   // Listen for incoming call invitations
//   // ZegoUIKitPrebuiltCallInvitationService().onInvitationReceived = (invitationData) {
//   //   log('Invitation received from ${invitationData.inviter.userName}');
//   //   // Handle the incoming call invitation
//   //   _showIncomingCallDialog(invitationData.inviter.userName);
//   // };
// }


// void _showIncomingCallDialog(String callerID) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Incoming Call'),
//         content: Text('You have an incoming call from $callerID'),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Accept'),
//             onPressed: () {
//               Navigator.of(context).pop();
//               // Accept the call and navigate to the call page
//               _acceptCall();
//             },
//           ),
//           TextButton(
//             child: const Text('Reject'),
//             onPressed: () {
//               Navigator.of(context).pop();
//               // Optionally, reject the call
//               _rejectCall();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// void _acceptCall() {
//   log('Call accepted');
//   // Logic for joining the call or handling the accepted call
// }

// void _rejectCall() {
//   log('Call rejected');
//   // Logic for rejecting the call
// }


// Future<void> sendCallInvitation() async {
//   List<String> invitees = [widget.calleeId]; // List of callee IDs
//   int timeout = 30; // Timeout in seconds

//   // Prepare the push configuration if needed
//   ZegoSignalingPluginPushConfig pushConfig = ZegoSignalingPluginPushConfig(
//     resourceID: 'resource_id', // Optional
//     title: 'Incoming Call',
//     message: 'You have an incoming call',
//   );

//   // Send the invitation
//   final result = await ZegoUIKitSignalingPlugin().sendInvitation(
//     invitees: invitees,
//     timeout: timeout,
//     isAdvancedMode: false,
//     extendedData: 'Calling you',
//     pushConfig: pushConfig,
//   );

//   // Check the result
//   if (result.error !=  null) {
//     log('Call invitation sent successfully to ${widget.calleeId}');
//   } else {
//     log('Failed to send invitation: ${result.error}');
//   }
// }



//   Future<void> joinRoom() async {
//     if (!isInRoom) {
//       ZegoUser user = ZegoUser(widget.userId, widget.userId);
//       ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig();

//       log('Attempting to join room: $roomID with user: ${widget.userId}');

//       ZegoExpressEngine.instance.loginRoom(roomID, user, config: roomConfig).then((result) {
//         if (result.errorCode == 0) {
//           setState(() {
//             isInRoom = true;
//           });
//           log('Successfully joined room: $roomID');
//           // startPreview(textureID);
//           sendCallInvitation(); // Send call invitation when joining the room
//         } else {
//           log('Login failed: ${result.errorCode}');
//         }
//       });
//     } else {
//       log('User is already in room: $roomID');
//     }
//   }

//   // The rest of your CallControlPage code remains unchanged...

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Call with ${widget.calleeId}'),
//       ),
//       // Rest of the UI code...
//     );
//   }
// }
