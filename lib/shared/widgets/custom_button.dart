import 'package:flutter/material.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? width;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text = 'Continue',
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
       style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(primaryColor), 
        fixedSize: WidgetStateProperty.resolveWith((states)=>Size(width ?? MediaQuery.of(context).size.width, 0)), 
        ), 
      child: Text(
        text,
        style: AppTheme.titleStyle(color: whiteColor),
      ),
    );
  }
}
