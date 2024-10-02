import 'package:call_tester/calling_config/screens/cal_page.dart';
import 'package:call_tester/calling_config/util.dart';
import 'package:call_tester/callinvitaion/experss_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String userId;
  const HomePage({super.key, required this.userName, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController roomController = TextEditingController();
  TextEditingController nameController = TextEditingController();




  @override
  void initState() {
    super.initState();
    checkPremission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: roomController,
              decoration: const InputDecoration(label: Text("Enter Room Id")),
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
                          roomController.text.isEmpty) {
                        message(context, "All fields are required");
                      } else {
                        // Navigate to call page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallView(
                              roomId: roomController.text.trim(),
                              name: nameController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text("Join Meeting")),
                TextButton(
                    onPressed: () {
                      if (nameController.text.isEmpty) {
                        message(context, "Name field is required");
                      } else {
                        //navigate
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallView(
                              name: nameController.text.trim(),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text("Create Meeting"))
              ],
            ),
            const Spacer(),
            IconButton(onPressed: () {
              ZIMService().sendVideoCallInvitation('11', '11');
            }, icon: const Icon(Icons.call))
          ],
        ),
      ),
    );
  }
}

void message(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class ZegoCallType {
  static const int audio = 0;
  static const int video = 1;
}
