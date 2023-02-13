import 'package:flutter/material.dart';
import 'package:flutter_http_get/add_data.dart';
import 'package:flutter_http_get/change_data.dart';
import 'package:flutter_http_get/models/model.dart';

import 'services/services.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var services = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[150],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[100],
        title: const Text("Get API HTTP"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddPage();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.add_circle,
              size: 45,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: services.getData(),
        builder: (context, snapshot) {
          //variabel untuk mengambil data snapshot
          final users = snapshot.data;
          //if untuk loading koneksi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(
                backgroundColor: Colors.blueGrey,
                color: Colors.amber,
              ),
            );
          } else if (snapshot.hasData) {
            //jika ada data tampilkan menggunakan ListView
            return ListView.builder(
              //variabel untuk mengambil panjang data
              itemCount: users!.length,
              itemBuilder: (context, index) {
                //variabel untuk mengambil data index
                final user = users[index];
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeDataPage(
                              paramId: user.id,
                              paramUsername: user.username,
                              paramPassword: user.password,
                            ),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.pest_control_sharp,
                        size: 35,
                        color: Colors.red,
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          bool response = await services.Delete(user.id);
                          if (response) {
                            print('Success : Data Deleted');
                          } else {
                            print('Failed Delete');
                          }
                          services.getData();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ID : ${user.id}'),
                          Text('Username : ${user.username}'),
                        ],
                      ),
                      subtitle: Text('Password : ${user.password}'),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: LinearProgressIndicator(
              backgroundColor: Colors.redAccent,
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
