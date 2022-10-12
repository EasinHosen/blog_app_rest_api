import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/network/network_requests.dart';
import 'package:flutter/cupertino.dart';

class BlogProvider extends ChangeNotifier {
  NetworkRequests networkRequests = NetworkRequests();
  late BlogResponseModel blogResponseModel;

  Future<BlogResponseModel> getBlogs() {
    return networkRequests.getBlogsRequest();
  }

  createBlog(BlogData blogDataModel) {
    networkRequests.createBlogRequest(blogDataModel);
    notifyListeners();
  }

  deleteBlog(int id) {
    networkRequests.deleteBlogRequest(id.toString());
    notifyListeners();
  }

  void updateBlog(BlogData blogDataModel) {
    networkRequests.updateBlogRequest(blogDataModel);
    notifyListeners();
  }
}
