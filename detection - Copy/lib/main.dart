import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/signup.dart';
import 'package:project/splashscreen.dart';
import 'homescreen.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SplashScreen()));
}
