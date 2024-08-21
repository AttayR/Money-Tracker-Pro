import 'package:flutter/material.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';

class LoanInfoCard extends StatelessWidget {
  final String loanName;
  final String loanAmount;
  final String fullName;
  final String incurredDate;
  final bool isLoaned;
  final LoanType loanType; 
  final VoidCallback onTap;

  const LoanInfoCard({
    super.key,
    required this.loanName,
    required this.fullName,
    required this.loanAmount,
    required this.incurredDate,
    required this.isLoaned,
    required this.loanType, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 150,
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.outbond,
                  color: isLoaned ? redColor : greenColor,
                ),
                Expanded(
                  child: Text(
                    loanAmount,
                    textAlign: TextAlign.right,
                    style: AppTheme.subTitleStyle(color: whiteColor),
                    overflow: TextOverflow.ellipsis, 
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              loanName,
              style: AppTheme.titleStyle(isBold: true, color: whiteColor),
              overflow: TextOverflow.ellipsis,  
            ),
            Text(
              loanType == LoanType.LoanGivenByMe ? 'Loaned to' : 'Borrowed from', // Display loan type
              style: AppTheme.titleStyle(isBold: true, color: whiteColor),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              fullName.ellipsis(),
              style: AppTheme.titleStyle(isBold: true, color: whiteColor),
              overflow: TextOverflow.ellipsis, 
            ),
            Text(
              "On",
              style: AppTheme.titleStyle(color: whiteColor),
              overflow: TextOverflow.ellipsis, 
            ),
            Text(
              incurredDate,
              style: AppTheme.titleStyle(isBold: true, color: whiteColor),
              overflow: TextOverflow.ellipsis,  
            ),
          ],
        ),
      ),
    );
  }
}
