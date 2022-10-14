import 'dart:convert';

import 'package:blog_app/models/blog_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';
import '../utils/auth_pref.dart';
import '../utils/constants.dart';

class NetworkRequests {
  LoginResponseModel? loginResponseModel;
  late BlogResponseModel blogResponseModel;
  late List<BlogData> blogList;

  Future<LoginResponseModel?> loginRequest(String email, String pass) async {
    final uri = Uri.parse('$baseUrl$loginUrl');

    try {
      final response =
          await post(uri, body: {'email': email, 'password': pass});

      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // print(json);
        loginResponseModel = LoginResponseModel.fromJson(json);
        return loginResponseModel;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  deleteBlogRequest(String id) {
    final uri = Uri.parse('$baseUrl$deleteUrl$id');

    getToken().then((value) async {
      try {
        final response = await delete(uri, headers: {
          'Authorization': 'Bearer $value',
        }, body: {
          'id': id,
        });
        if (response.statusCode == 200) {
          EasyLoading.showToast('Deleted successfully!');
        } else {
          EasyLoading.showToast('Something went wrong!');
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  Future<List<BlogData>> getBlogListRequest() async {
    final uri = Uri.parse('$baseUrl$blogsUrl');

    final token = await getToken();
    try {
      final response = await get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        blogResponseModel = BlogResponseModel.fromJson(json);
        blogList = blogResponseModel.data!.blogs!.data!;
        print('network: list length- ${blogList.length}');

        return blogList;
      } else {
        EasyLoading.showToast('Something went wrong!');
      }
    } catch (e) {
      rethrow;
    }
    return blogList;
  }

  createBlogRequest(BlogData blogDataModel) {
    final uri = Uri.parse('$baseUrl$createUrl');

    getToken().then((value) async {
      try {
        final response = await post(
          uri,
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(blogDataModel),
        );
        if (response.statusCode == 200) {
          EasyLoading.showToast('Created successfully!');
        } else {
          EasyLoading.showToast('Something went wrong!');
        }
      } catch (e) {
        rethrow;
      }
    });
  }

  updateBlogRequest(BlogData blogDataModel) {
    final uri = Uri.parse('$baseUrl$updateUrl${blogDataModel.id}');

    getToken().then((value) async {
      try {
        final response = await post(
          uri,
          headers: {
            'Authorization': 'Bearer $value',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(blogDataModel),
        );
        if (response.statusCode == 200) {
          EasyLoading.showToast('Updated successfully!');
        } else {
          EasyLoading.showToast('Something went wrong!');
        }
      } catch (e) {
        rethrow;
      }
    });
  }
}
