import 'package:flutter/material.dart';
import 'package:flutter_http_get/home_page.dart';

import 'services/services.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //access services
  UserServices _userServices = UserServices();
  //text controller
  final _usernameTextController = TextEditingController();
  final _passTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            TextField(
              controller: _passTextController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await _userServices.postData(
                  _usernameTextController.text,
                  _passTextController.text,
                );

                if (response == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false,
                  );
                }
              },
              child: Text("ADD Data User"),
            ),
          ],
        ),
      ),
    );
  }
}
