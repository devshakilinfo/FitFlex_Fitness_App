import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:fit_flex3/app.dart' show FitFlex;
import 'package:fit_flex3/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FitFlex());
}
/*
{
    "email":"korim_mola@gmail.com",
    "password":"1"
}
*/