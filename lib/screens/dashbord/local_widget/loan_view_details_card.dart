 import 'package:flutter/widgets.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/styles/theme.dart';

class LoanViewDetailsCard extends StatelessWidget {
  final String headerText;
  final String titleText;
  const LoanViewDetailsCard({super.key,required this.headerText,required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: AppTheme.headerStyle(),
        ),
        8.height(),
        Text(
          titleText,
          style: AppTheme.titleStyle(),
        ),
        15.height(),
        

      ],
    );
  }
}