import 'package:flutter/material.dart';
import 'package:flutter_http_get/models/model.dart';

import 'services/services.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var services = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text("Get API HTTP [GET]"),
        centerTitle: true,
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
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID : ${user.id}'),
                      Text('Username :${user.username}'),
                    ],
                  ),
                  subtitle: Text('Password :${user.password}'),
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
