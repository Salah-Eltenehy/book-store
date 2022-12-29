import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_processing/screen/login.dart';

import 'Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animated Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
      ),
      home: LoginScreen(),
    );
  }
}