import 'package:blog_app/models/user_model.dart';
import 'package:blog_app/network/network_requests.dart';
import 'package:blog_app/utils/auth_pref.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  LoginResponseModel? loginResponseModel;
  bool loginSucceeded = false;

  NetworkRequests networkRequests = NetworkRequests();

  loginUser(String email, String pass) async {
    loginResponseModel = await networkRequests.loginRequest(email, pass);
    loginSucceeded = true;
    setLoginStat(true);
    setToken(loginResponseModel!.data!.token!);
    notifyListeners();
  }

  logout() {
    print('logout called in provider');
    // setLoginStat(false);
    // setToken('');
    notifyListeners();
  }
}
