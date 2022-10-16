import 'package:blog_app/provider/user_provider.dart';
import 'package:blog_app/ui/pages/launcher_page.dart';
import 'package:blog_app/ui/pages/update_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../provider/blog_provider.dart';
import 'blog_details_page.dart';
import 'new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);
  static const String routeName = '/blog_page';

  @override
  Widget build(BuildContext context) {
    Provider.of<BlogProvider>(context, listen: false).getBlogs();
    RefreshController refreshController =
        RefreshController(initialRefresh: false);

    void onRefresh() async {
      await Provider.of<BlogProvider>(context, listen: false).getBlogs();
      EasyLoading.showToast('Page refreshed');
      refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: const Text('Logout'),
                  onTap: () {
                    _showConfirmation(context, 'Logging out?').then(
                      (value) {
                        if (value == true) {
                          Provider.of<UserProvider>(context, listen: false)
                              .logout();
                          Navigator.pushReplacementNamed(
                              context, LauncherPage.routeName);
                          EasyLoading.showToast('Logged out');
                        }
                      },
                    );
                  }),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, NewBlogPage.routeName).then((value) {
            if (value != null) {
              EasyLoading.showToast('New blog created!');
            } else {
              EasyLoading.showToast('Canceled!');
            }
          });
        },
      ),
      body: Center(
        child: Consumer<BlogProvider>(
          builder: (context, blogProvider, child) {
            final blogList = blogProvider.blogList;
            return blogList.isEmpty && !blogProvider.loadingError
                ? const CircularProgressIndicator()
                : blogProvider.loadingError
                    ? const Text('Error loading data!')
                    : SmartRefresher(
                        onRefresh: onRefresh,
                        controller: refreshController,
                        child: ListView.builder(
                          itemCount: blogList.length,
                          itemBuilder: (context, index) {
                            final blog = blogList[index];
                            return ListTile(
                              title: Text(blog.title!),
                              subtitle: Text(blog.subTitle!),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 1,
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 2,
                                      child: Text('Delete'),
                                    ),
                                  ];
                                },
                                onSelected: (int value) {
                                  if (value == 1) {
                                    Navigator.pushNamed(
                                      context,
                                      UpdateBlogPage.routeName,
                                      arguments: [blog, index],
                                    ).then(
                                      (value) {
                                        if (value != null) {
                                          EasyLoading.showToast(
                                              'Blog updated!');
                                        } else {
                                          EasyLoading.showToast('Canceled');
                                        }
                                      },
                                    );
                                  } else if (value == 2) {
                                    _showConfirmation(context, 'Delete blog?')
                                        .then(
                                      (value) {
                                        if (value == true) {
                                          blogProvider.deleteBlog(
                                              blog.id!, index);
                                        }
                                      },
                                    );
                                  }
                                },
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  BlogDetailsPage.routeName,
                                  arguments: blog,
                                );
                              },
                            );
                          },
                        ),
                      );
          },
        ),
      ),
    );
  }

  Future<bool?> _showConfirmation(BuildContext context, String title) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('no'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('yes'),
          ),
        ],
      ),
    );
  }
}
