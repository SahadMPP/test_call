// // import 'package:call_tester/calling_view.dart';
// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: CallInitiationPage(),
// //     );
// //   }
// // }

// // class CallInitiationPage extends StatelessWidget {
// //   final TextEditingController userIdController = TextEditingController();
// //   final TextEditingController calleeIdController = TextEditingController(); // New TextEditingController for callee ID

// //   void _startCall(BuildContext context) {
// //     String userId = userIdController.text.isNotEmpty ? userIdController.text : "user1";
// //     String calleeId = calleeIdController.text.isNotEmpty ? calleeIdController.text : "user2"; // Default callee ID

// //     Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //         builder: (context) => CallControlPage(userId: userId, calleeId: calleeId), // Pass callee ID
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Start Call'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: userIdController,
// //               decoration: InputDecoration(
// //                 labelText: 'Enter User ID',
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             TextField(
// //               controller: calleeIdController, // New TextField for callee ID
// //               decoration: InputDecoration(
// //                 labelText: 'Enter Callee ID',
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: () => _startCall(context),
// //               child: Text('Call'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:call_tester/callinvitaion/experss_service.dart';
// import 'package:call_tester/callinvitaion/screens/home_callinvitation.dart';
// import 'package:flutter/material.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';

// main()async {
//    WidgetsFlutterBinding.ensureInitialized();
//   // Get your AppID and AppSign from ZEGOCLOUD Console
//   //[My Projects -> AppID] : https://console.zegocloud.com/project
//   await ZegoExpressEngine.createEngineWithProfile(ZegoEngineProfile(
//     1047661351,
//     ZegoScenario.StandardVoiceCall,
//     appSign:'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c',
//   ));

//   ZEGOSDKManager().init(appID:1047661351 ,appSign:'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c' );

 
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         home:HomePageCallInvitation(),
//         );
//   }
// }
import 'package:call_tester/callinvitaion/experss_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zego Call App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Set the LoginPage as the home
    );
  }
}


class CallPage extends StatelessWidget {
  final String targetUserID = '11';

  const CallPage({super.key}); // Replace with the actual user ID to call

  Future<void> _sendCallInvitation(BuildContext context) async {
    try {
      final result = await ZEGOSDKManager.instance.zimService.sendVideoCallInvitation(targetUserID,'11');
      // Handle the result (e.g., show success message)
      // if (result.errorCode == 0) {
      //   // Invitation sent successfully
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Call invitation sent!')),
      //   );
      // } else {
      //   // Handle error
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Error sending invitation: ${result.errorCode}')),
      //   );
      // }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send invitation: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Call')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _sendCallInvitation(context), // Pass context to the method
          child: Text('Send Call Invitation'),
        ),
      ),
    );
  }
}




class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIDController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeZIMService();
  }

  Future<void> _initializeZIMService() async {
    int appID = 1047661351; // Replace with your actual App ID
    String appSign = 'c83b3a438b44b4e26f2d736dddc8745b79a5e43486b1ec3d112af78add45692c'; // Replace with your actual App Sign
    await ZEGOSDKManager.instance.init(appID,appSign );
  }

  Future<void> _login() async {
    String userID = _userIDController.text;
    String userName = _userNameController.text;

    if (userID.isNotEmpty && userName.isNotEmpty) {
      try {
        // Attempt to connect the user
        await ZEGOSDKManager.instance.connectUser( userID,userName);
        // Navigate to CallPage only if login is successful
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CallPage(),
        ));
      } catch (e) {
        // Show error message if login fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
    } else {
      // Show error message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter User ID and Username')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _userIDController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
