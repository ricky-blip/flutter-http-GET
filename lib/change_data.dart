import 'package:flutter/material.dart';
import 'package:flutter_http_get/home_page.dart';

import 'services/services.dart';

class ChangeDataPage extends StatefulWidget {
  ChangeDataPage({
    super.key,
    required this.paramId,
    required this.paramUsername,
    required this.paramPassword,
  });

  String paramId;
  String paramUsername;
  String paramPassword;
  @override
  State<ChangeDataPage> createState() => _ChangeDataPageState();
}

class _ChangeDataPageState extends State<ChangeDataPage> {
  //access services
  UserServices _userServices = UserServices();
  //text controller
  var usernameTextController = TextEditingController();
  var passTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: usernameTextController,
              decoration: InputDecoration(hintText: widget.paramUsername),
            ),
            TextField(
              controller: passTextController,
              decoration: InputDecoration(hintText: widget.paramPassword),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await _userServices.putData(
                  widget.paramId,
                  usernameTextController.text,
                  passTextController.text,
                );

                if (response == true) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false,
                  );
                } else {
                  Text('gagal');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.update_rounded),
                  SizedBox(width: 10),
                  Text("[PUT] Change/Update Data User"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
