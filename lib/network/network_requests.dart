import 'dart:convert';

import 'package:blog_app/models/blog_model.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';
import '../utils/auth_pref.dart';
import '../utils/constants.dart';

class NetworkRequests {
  LoginResponseModel? loginResponseModel;
  late BlogResponseModel blogResponseModel;

  // Future<LoginResponseModel?> loginRequest(String email, String pass) async {
  //   final uri = Uri.parse('$baseUrl$loginUrl');
  //
  //   try {
  //     final response =
  //         await post(uri, body: {'email': email, 'password': pass});
  //
  //     final json = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200) {
  //       // print(json);
  //       loginResponseModel = LoginResponseModel.fromJson(json);
  //       return loginResponseModel;
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  //   return null;
  // }

  Future<Response> loginRequestResponse(String email, String pass) async {
    final uri = Uri.parse('$baseUrl$loginUrl');

    try {
      return await post(uri, body: {'email': email, 'password': pass});
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> blogModelRequestResponse() async {
    final uri = Uri.parse('$baseUrl$blogsUrl');

    final token = await getToken();
    try {
      return await get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteBlogRequestResponse(String id) async {
    final uri = Uri.parse('$baseUrl$deleteUrl$id');

    final token = await getToken();

    try {
      return await delete(uri, headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        'id': id,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateBlogRequestResponse(BlogData blogDataModel) async {
    final uri = Uri.parse('$baseUrl$updateUrl${blogDataModel.id}');

    final token = await getToken();

    try {
      return await post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(blogDataModel),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createBlogRequestResponse(BlogData blogDataModel) async {
    final uri = Uri.parse('$baseUrl$createUrl');

    final token = await getToken();

    try {
      return await post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(blogDataModel),
      );
    } catch (e) {
      rethrow;
    }
  }
}
