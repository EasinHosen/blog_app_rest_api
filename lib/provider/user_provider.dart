import 'dart:convert';

import 'package:blog_app/models/user_model.dart';
import 'package:blog_app/utils/auth_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../utils/constants.dart';

class UserProvider extends ChangeNotifier {
  LoginResponseModel? loginResponseModel;
  User? user;

  bool loginSucceeded = false;
  bool logoutSucceeded = false;

  loginUser(String email, String pass) async {
    final uri = Uri.parse('$baseUrl/login');

    try {
      final response =
          await post(uri, body: {'email': email, 'password': pass});

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print(json);
        loginResponseModel = LoginResponseModel.fromJson(json);
        user = loginResponseModel!.data!.user!;
        loginSucceeded = true;
        setLoginStat(true);
        setToken(loginResponseModel!.data!.token!);

        // print(loginResponseModel!.message);
        // print(user!.name);
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  logout() async {
    final uri = Uri.parse('$baseUrl/logout');

    getToken().then((value) async {
      try {
        final response = await post(
          uri,
          headers: {
            'Authorization': 'Bearer $value',
          },
          body: {},
        );
        print(response.statusCode);

        if (response.statusCode == 200) {
          logoutSucceeded = true;
          setLoginStat(false);
          setToken('');
        }
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    });
  }
}
