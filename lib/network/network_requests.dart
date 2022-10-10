import 'dart:convert';

import 'package:blog_app/models/blog_model.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';
import '../utils/auth_pref.dart';
import '../utils/constants.dart';

class NetworkRequests {
  LoginResponseModel? loginResponseModel;
  BlogResponseModel? blogResponseModel;
  List<BlogData> blogList = [];

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

  deleteBlogRequest(int id) {
    final uri = Uri.parse('$baseUrl$deleteUrl$id');

    getToken().then((value) async {
      try {
        final response = await delete(uri, headers: {
          'Authorization': 'Bearer $value',
        }, body: {
          'id': id,
        });
        print(response.statusCode);
      } catch (e) {
        rethrow;
      }
    });
  }

  List<BlogData> getBlogsRequest() {
    final uri = Uri.parse('$baseUrl$blogsUrl');

    getToken().then((value) async {
      try {
        final response = await get(
          uri,
          headers: {
            'Authorization': 'Bearer $value',
          },
        );
        final json = jsonDecode(response.body);
        // print(response.statusCode);

        if (response.statusCode == 200) {
          blogResponseModel = BlogResponseModel.fromJson(json);
          blogList = blogResponseModel!.data!.blogs!.data!;

          return blogList;
        } else {
          print('something went wrong');
        }
      } catch (e) {
        rethrow;
      }
    });
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
          //     body: {
          //   'mode': 'formdata',
          //   'formdata': '[${jsonEncode(blogDataModel)}]'
          // })
          body: jsonEncode(blogDataModel),
        );
        print(response.statusCode);
        print(response.body);
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
          //     body: {
          //   'mode': 'formdata',
          //   'formdata': '[${jsonEncode(blogDataModel)}]'
          // })
          body: jsonEncode(blogDataModel),
        );
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          print('updated');
        }
      } catch (e) {
        rethrow;
      }
    });
  }
}
