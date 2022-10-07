import 'dart:convert';

import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/utils/auth_pref.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class BlogProvider extends ChangeNotifier {
  BlogResponseModel? blogResponseModel;

  // List<BlogData> blogsList = [];

  bool get hasDataLoaded => blogResponseModel != null;

  getBlogs() {
    final uri = Uri.parse('$baseUrl/admin/blog-news');

    getToken().then((value) async {
      try {
        final response = await get(
          uri,
          headers: {
            'Authorization': 'Bearer $value',
          },
        );
        final json = jsonDecode(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          blogResponseModel = BlogResponseModel.fromJson(json);
          // blogsList = blogResponseModel!.data!.blogs!.data!;

          // print(blogResponseModel!.message);
          // print(blogResponseModel!.data!.blogs!.total);
        } else {
          print('something went wrong');
        }
      } catch (e) {
        rethrow;
      }
    });
    notifyListeners();
  }

  createBlog(BlogData blogDataModel) {
    final uri = Uri.parse('$baseUrl/admin/blog-news/store');

    getToken().then((value) async {
      try {
        final response = await post(uri, headers: {
          'Authorization': 'Bearer $value',
        }, body: {
          'mode': 'formdata',
          'formdata': '[${jsonEncode(blogDataModel)}]'
        });
        print(response.statusCode);
        print(response.body);
      } catch (e) {
        rethrow;
      }
    });
    notifyListeners();
  }

  deleteBlog(int id) {
    final uri = Uri.parse('$baseUrl/admin/blog-news/delete/$id');

    getToken().then((value) async {
      try {
        final response = await delete(uri, headers: {
          'Authorization': 'Bearer $value',
        }, body: {
          'id': '$id',
        });
        print(response.statusCode);

        if (response.statusCode == 200) {
          print(blogResponseModel!.message);
        } else {
          print('something went wrong');
        }
      } catch (e) {
        rethrow;
      }
    });
    notifyListeners();
  }

  void updateBlog(BlogData blogDataModel) {
    final uri =
        Uri.parse('$baseUrl/admin/blog-news/update/${blogDataModel.id}');

    getToken().then((value) async {
      try {
        final response = await post(uri, headers: {
          'Authorization': 'Bearer $value',
        }, body: {
          'mode': 'formdata',
          'formdata': '[${jsonEncode(blogDataModel)}]'
        });
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          print('updated blog');
        } else {
          print('something went wrong');
        }
      } catch (e) {
        rethrow;
      }
    });
    notifyListeners();
  }
}
