import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/ui/pages/blog_page.dart';
import 'package:blog_app/ui/pages/login_page.dart';
import 'package:blog_app/utils/auth_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  static const String routeName = '/launcher_page';

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    // TODO: implement initState
    getLoginStat().then((value) {
      if (value) {
        getToken().then((token) async => {
              if (token != null || token!.isNotEmpty)
                {
                  await Provider.of<BlogProvider>(context, listen: false)
                      .getBlogs(),
                  Navigator.pushReplacementNamed(context, BlogPage.routeName),
                }
            });
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
