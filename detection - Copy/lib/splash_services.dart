import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/homescreen.dart';
import 'package:project/login.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => Login(
                      controller: passwordController,
                    )))));
  }
}
