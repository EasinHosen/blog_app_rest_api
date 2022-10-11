import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/provider/user_provider.dart';
import 'package:blog_app/ui/pages/blog_details_page.dart';
import 'package:blog_app/ui/pages/launcher_page.dart';
import 'package:blog_app/ui/pages/update_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/auth_pref.dart';
import 'new_blog_page.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  static const String routeName = '/blog_page';

  @override
  Widget build(BuildContext context) {
    getToken().then((value) => print(value));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text(
                  'Logout',
                ),
                onTap: () async {
                  await Provider.of<UserProvider>(context, listen: false)
                      .logout();
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName);
                },
              ),
              PopupMenuItem(
                child: const Text(
                  'Refresh',
                ),
                onTap: () async {
                  await Provider.of<BlogProvider>(context, listen: false)
                      .getBlogs();
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, NewBlogPage.routeName);
        },
      ),
      body: SafeArea(
        child: Consumer<BlogProvider>(
          builder: ((context, blogProvider, _) {
            return blogProvider.blogsList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: blogProvider.blogsList.length,
                    itemBuilder: (context, index) {
                      final blogDataModel = blogProvider.blogsList[index];
                      // print('id: ${blogDataModel.id}, title: ${blogDataModel.title}');
                      return ListTile(
                        title: Text(blogDataModel.title!),
                        subtitle: Text(blogDataModel.subTitle!),
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
                                arguments: blogDataModel,
                              );
                              print('edit');
                            } else if (value == 2) {
                              _showConfirmation(context).then((value) {
                                if (value == true) {
                                  blogProvider.deleteBlog(blogDataModel.id!);
                                  // blogsList.removeWhere((element) =>
                                  //     element.id == blogDataModel.id);
                                }
                              });
                            }
                          },
                        ),
                        onTap: () => Navigator.pushNamed(
                            context, BlogDetailsPage.routeName,
                            arguments: blogDataModel),
                      );
                    },
                  );
          }),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete blog'),
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
