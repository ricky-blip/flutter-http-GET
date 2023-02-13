import 'dart:convert';

import 'package:flutter_http_get/config/config.dart';
import 'package:flutter_http_get/models/model.dart';
import 'package:http/http.dart' as http;

class UserServices {
  //SECTION GET
  Future<List<UserModel>> getData() async {
    //SECTION Get Data
    List<UserModel> listUser = [];

    try {
      //ambil endPoint
      final response = await http.get(Uri.parse(baseUrl));
      //cek koneksi
      if (response.statusCode == 200) {
        //ambil body
        var body = jsonDecode(response.body);
        //masukkan body ke variabel List
        print('data Body setelah di Decode : $body');
        List listResponse = body;
        print('Body yang telah menjadi List : $listResponse');
        //looping
        for (var element in listResponse) {
          listUser.add(UserModel.fromJson(element));
        }
        print('hasil looping : $listResponse');
      } else {
        listUser = [];
      }
    } catch (e) {
      print(e.toString());
    }
    return listUser;
  }

  //SECTION PUT/CHANGE
  Future putData(
    String id,
    String usernameput,
    String passwordput,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        body: {
          "username": usernameput,
          "password": passwordput,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  //SECTION POST DATA
  Future postData(
    String usernameparam,
    String passwordparam,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: {
          "username": usernameparam,
          "password": passwordparam,
        },
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  //SECTION DELETE DATA
  Future Delete(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
