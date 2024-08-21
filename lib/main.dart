import 'package:flutter/material.dart';
import 'package:manage_loan/config/router.dart';
import 'package:manage_loan/styles/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: true,scrolledUnderElevation: 0,backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: whiteColor,
        primaryColor: primaryColor
      ),
    );
  }
}