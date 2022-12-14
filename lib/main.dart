import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/provider/user_provider.dart';
import 'package:blog_app/ui/pages/blog_details_page.dart';
import 'package:blog_app/ui/pages/blog_page.dart';
import 'package:blog_app/ui/pages/launcher_page.dart';
import 'package:blog_app/ui/pages/login_page.dart';
import 'package:blog_app/ui/pages/new_blog_page.dart';
import 'package:blog_app/ui/pages/update_blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (create) => UserProvider()),
        ChangeNotifierProvider(create: (create) => BlogProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..toastPosition = EasyLoadingToastPosition.bottom;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        BlogPage.routeName: (context) => const BlogPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        NewBlogPage.routeName: (context) => const NewBlogPage(),
        UpdateBlogPage.routeName: (context) => const UpdateBlogPage(),
        BlogDetailsPage.routeName: (context) => const BlogDetailsPage(),
      },

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
