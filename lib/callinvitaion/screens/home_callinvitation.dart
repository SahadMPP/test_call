import 'package:call_tester/calling_config/screens/home_page.dart';
import 'package:call_tester/callinvitaion/experss_service.dart';
import 'package:flutter/material.dart';

class HomePageCallInvitation extends StatefulWidget {
  const HomePageCallInvitation({super.key});

  @override
  State<HomePageCallInvitation> createState() => _HomePageCallInvitationState();
}

class _HomePageCallInvitationState extends State<HomePageCallInvitation> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page call Invitation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: userIdController,
              decoration: const InputDecoration(label: Text("Enter userId")),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(label: Text("Enter Username")),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          userIdController.text.isEmpty) {
                        message(context, "All fields are required");
                      } else {
                        // Navigate to call page
                        ZEGOSDKManager().connectUser(
                             userIdController.text,
                             nameController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  HomePage(userId:userIdController.text ,userName: nameController.text),
                          ),
                        );
                      }
                    },
                    child: const Text("user Register")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void message(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
