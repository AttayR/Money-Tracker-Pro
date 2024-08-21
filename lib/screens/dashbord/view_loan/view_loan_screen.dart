import 'package:flutter/material.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/screens/dashbord/local_widget/loan_view_details_card.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewLoanScreen extends StatefulWidget {
  const ViewLoanScreen({super.key});

  @override
  State<ViewLoanScreen> createState() => _ViewLoanScreenState();
}

class _ViewLoanScreenState extends State<ViewLoanScreen> {
  String loanName = '';
  String loanAmount = '';
  String loanCurrency = '';
  String incurredDate = '';
  String dueDate = '';
  String fullName = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _loadLoanData();
  }

  Future<void> _loadLoanData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loanName = prefs.getString('loanName') ?? 'N/A';
      loanAmount = prefs.getString('loanAmount') ?? 'N/A';
      loanCurrency = prefs.getString('loanCurrency') ?? 'N/A';
      incurredDate = prefs.getString('incurredDate') ?? 'N/A';
      dueDate = prefs.getString('dueDate') ?? 'N/A';
      fullName = prefs.getString('fullName') ?? 'N/A';
      phoneNumber = prefs.getString('phoneNumber') ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor ,
        title: Text('Loan Details', style: AppTheme.headerStyle(color: whiteColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoanViewDetailsCard(
              titleText: loanName,
              headerText: "Loan Name",
            ),
            LoanViewDetailsCard(
              titleText: "$loanCurrency $loanAmount",
              headerText: "Loan Amount",
            ),
            15.height(),
            Row(
              children: [
                LoanViewDetailsCard(
                  titleText: incurredDate,
                  headerText: "Incurred Date",
                ),
                const Spacer(),
                LoanViewDetailsCard(
                  titleText: dueDate,
                  headerText: "Due Date",
                ),
              ],
            ),
            10.height(),
            const Divider(),
            10.height(),
            Text(
              "Debtor's Details",
              style: AppTheme.headerStyle(),
            ),
            const Divider(),
            10.height(),
            LoanViewDetailsCard(
              titleText: fullName,
              headerText: "Full Name",
            ),
            LoanViewDetailsCard(
              titleText: phoneNumber,
              headerText: "Phone Number",
            ),
          ],
        ),
      ),
    );
  }
}
