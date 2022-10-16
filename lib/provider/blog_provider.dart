import 'dart:convert';

import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/network/network_requests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';

class BlogProvider extends ChangeNotifier {
  NetworkRequests networkRequests = NetworkRequests();
  late BlogResponseModel blogResponseModel;
  late Response blogModelResponse,
      deleteBlogRequestResponse,
      updateBlogRequestResponse,
      createBlogRequestResponse;

  bool loadingError = false;

  List<BlogData> blogList = [];

  Future<void> getBlogs() async {
    blogModelResponse = await networkRequests.blogModelRequestResponse();
    final json = jsonDecode(blogModelResponse.body);
    if (blogModelResponse.statusCode == 200) {
      blogResponseModel = BlogResponseModel.fromJson(json);
      blogList = blogResponseModel.data!.blogs!.data!;
      loadingError = false;
    } else {
      loadingError = true;
    }
    notifyListeners();
  }

  Future<void> createBlog(BlogData blogDataModel) async {
    createBlogRequestResponse =
        await networkRequests.createBlogRequestResponse(blogDataModel);
    if (createBlogRequestResponse.statusCode == 200) {
      blogList[0] = blogDataModel;
    } else {
      EasyLoading.showToast('Something went wrong!');
    }
    notifyListeners();
  }

  Future<void> deleteBlog(int id, int index) async {
    deleteBlogRequestResponse =
        await networkRequests.deleteBlogRequestResponse(id.toString());
    if (deleteBlogRequestResponse.statusCode == 200) {
      blogList.removeWhere((element) => element.id! == blogList[index].id);
      EasyLoading.showToast('Deleted');
    } else {
      EasyLoading.showToast('could not delete blog!');
    }
    notifyListeners();
  }

  Future<void> updateBlog(BlogData blogDataModel, int index) async {
    updateBlogRequestResponse =
        await networkRequests.updateBlogRequestResponse(blogDataModel);
    if (updateBlogRequestResponse.statusCode == 200) {
      blogList[index] = blogDataModel;
    } else {
      EasyLoading.showToast('Something went wrong!');
    }
    notifyListeners();
  }
}
