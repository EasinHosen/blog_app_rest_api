import 'dart:convert';

import 'package:blog_app/models/user_model.dart';
import 'package:blog_app/network/network_requests.dart';
import 'package:blog_app/utils/auth_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProvider extends ChangeNotifier {
  LoginResponseModel? loginResponseModel;
  bool loginSucceeded = false;
  late Response loginRequestResponse;

  NetworkRequests networkRequests = NetworkRequests();

  // loginUser(String email, String pass) async {
  //   loginResponseModel = await networkRequests.loginRequest(email, pass);
  //   loginSucceeded = true;
  //   setLoginStat(true);
  //   setToken(loginResponseModel!.data!.token!);
  //   notifyListeners();
  // }
  Future<void> loginUser(String email, String pass) async {
    loginRequestResponse =
        await networkRequests.loginRequestResponse(email, pass);

    if (loginRequestResponse.statusCode == 200) {
      final json = jsonDecode(loginRequestResponse.body);

      loginResponseModel = LoginResponseModel.fromJson(json);
      await setToken(loginResponseModel!.data!.token!);
      await setLoginStat(true);
      loginSucceeded = true;
    }
    notifyListeners();
  }

  logout() {
    setLoginStat(false);
    setToken('');
    notifyListeners();
  }
}
