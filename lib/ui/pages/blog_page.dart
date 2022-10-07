import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/provider/user_provider.dart';
import 'package:blog_app/ui/pages/launcher_page.dart';
import 'package:blog_app/ui/pages/new_blog_page.dart';
import 'package:blog_app/ui/pages/update_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/auth_pref.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  static const String routeName = '/blog_page';

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    //Provider.of<BlogProvider>(context, listen: false).getBlogs();
    BlogResponseModel? blogResponseModel;

    getToken().then((value) => print(value));
    // print(provider.user?.name);
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
                  await userProvider.logout();
                  setLoginStat(false).then((value) {
                    if (value) {
                      setToken('');
                      Navigator.pushReplacementNamed(
                          context, LauncherPage.routeName);
                      SnackBar snackBar =
                          const SnackBar(content: Text('Logout Successful!'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      SnackBar snackBar = const SnackBar(
                        content: Text('Something went wrong!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
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
            // blogProvider.getBlogs();
            blogResponseModel = blogProvider.blogResponseModel!;
            List<BlogData> blogsList = blogResponseModel!.data!.blogs!.data!;
            return blogProvider.hasDataLoaded == false
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: blogsList.length,
                    itemBuilder: (context, index) {
                      final blogDataModel = blogsList[index];
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
                                  blogsList.removeWhere((element) =>
                                      element.id == blogDataModel.id);
                                }
                              });
                            }
                          },
                        ),
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
