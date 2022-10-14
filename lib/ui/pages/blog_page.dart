import 'package:blog_app/models/blog_model.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/provider/user_provider.dart';
import 'package:blog_app/ui/pages/launcher_page.dart';
import 'package:blog_app/ui/pages/update_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../utils/auth_pref.dart';
import 'blog_details_page.dart';
import 'new_blog_page.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);
  static const String routeName = '/blog_page';

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  late Future<BlogResponseModel> blogResponseModel;
  late final BlogProvider blogProvider;
  // late List<BlogData> blogList;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    blogProvider = Provider.of<BlogProvider>(context, listen: false);
    // blogResponseModel = blogProvider.getBlogs();
  }

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
                  'Refresh',
                ),
                onTap: () {
                  // blogProvider.getBlogs();
                  blogProvider.getBlogList();
                  setState(() {});
                },
              ),
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
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, NewBlogPage.routeName).then((value) {
            if (value != null) {
              // print(value);
              setState(() {
                // blogList.insert(0, value as BlogData);
              });
            } else {
              print('canceled');
            }
          });
        },
      ),
      body: SafeArea(
        child: FutureBuilder<List<BlogData>>(
          future: blogProvider.getBlogList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                // itemCount: blogList.length,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final blog = snapshot.data![index];
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
                            arguments: blog,
                          ).then((value) {
                            if (value != null) {
                              blogProvider
                                  .getBlogList()
                                  .then((value) => setState(() {}));
                            } else {
                              EasyLoading.showToast('Canceled');
                            }
                          });
                        } else if (value == 2) {
                          _showConfirmation(context).then((value) {
                            if (value == true) {
                              blogProvider.deleteBlog(blog.id!);
                              setState(() {});
                            }
                          });
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, BlogDetailsPage.routeName,
                          arguments: blog);
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Failed to load data!'));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
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
