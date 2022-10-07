import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import 'blog_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();

  late UserProvider provider =
      Provider.of<UserProvider>(context, listen: false);

  bool isObscure = true;
  bool isNewUser = false;

  final form_key = GlobalKey<FormState>();

  @override
  void dispose() {
    userEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: form_key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field cannot be empty';
                    }
                    return null;
                  },
                  controller: userEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'This field cannot be empty';
                    } else if (val.length < 6) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: (isObscure
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _loginUser,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    if (form_key.currentState!.validate()) {
      await provider.loginUser(
          userEmailController.text, passwordController.text);

      if (provider.loginSucceeded) {
        // String token = provider.userModel!.data!.token!;
        // print(token);
        SnackBar snackBar = const SnackBar(content: Text('Login Successful!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, BlogPage.routeName);
        // print(getLoginStat());
        // print(getToken());
      } else {
        SnackBar snackBar =
            const SnackBar(content: Text('Something went wrong!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }
}
