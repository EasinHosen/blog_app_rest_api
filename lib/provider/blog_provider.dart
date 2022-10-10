import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/network/network_requests.dart';
import 'package:flutter/cupertino.dart';

class BlogProvider extends ChangeNotifier {
  NetworkRequests networkRequests = NetworkRequests();
  BlogResponseModel? blogResponseModel;

  List<BlogData> blogsList = [];

  getBlogs() {
    blogsList = networkRequests.getBlogsRequest();
    notifyListeners();
  }

  createBlog(BlogData blogDataModel) {
    networkRequests.createBlogRequest(blogDataModel);
    notifyListeners();
  }

  deleteBlog(int id) {
    networkRequests.deleteBlogRequest(id);
    notifyListeners();
  }

  void updateBlog(BlogData blogDataModel) {
    networkRequests.updateBlogRequest(blogDataModel);
    notifyListeners();
  }
}
