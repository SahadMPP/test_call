// import 'package:call_tester/calling_view.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CallInitiationPage(),
//     );
//   }
// }

// class CallInitiationPage extends StatelessWidget {
//   final TextEditingController userIdController = TextEditingController();
//   final TextEditingController calleeIdController = TextEditingController(); // New TextEditingController for callee ID

//   void _startCall(BuildContext context) {
//     String userId = userIdController.text.isNotEmpty ? userIdController.text : "user1";
//     String calleeId = calleeIdController.text.isNotEmpty ? calleeIdController.text : "user2"; // Default callee ID

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => CallControlPage(userId: userId, calleeId: calleeId), // Pass callee ID
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Start Call'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: userIdController,
//               decoration: InputDecoration(
//                 labelText: 'Enter User ID',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             TextField(
//               controller: calleeIdController, // New TextField for callee ID
//               decoration: InputDecoration(
//                 labelText: 'Enter Callee ID',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _startCall(context),
//               child: Text('Call'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:call_tester/calling_config/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

main()async {
   WidgetsFlutterBinding.ensureInitialized();
  // Get your AppID and AppSign from ZEGOCLOUD Console
  //[My Projects -> AppID] : https://console.zegocloud.com/project
  await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
    1047661351,
    ZegoScenario.StandardVoiceCall,
    appSign:'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home:HomePage(),
        );
  }
}
