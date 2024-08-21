import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_loan/config/constant.dart';
import 'package:manage_loan/styles/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 120, height: 120), // Updated to use image
            Text(appName, style: AppTheme.headerStyle()),
            Text("Better way to keep track of your loans", style: AppTheme.titleStyle()),
          ],
        ),
      ),
    );
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {  
        GoRouter.of(context).go('/loan_dashbord');
      }
    });
  }
}
