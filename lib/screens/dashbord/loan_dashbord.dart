import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:manage_loan/screens/dashbord/local_widget/loan_info_card.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanDashbord extends StatefulWidget {
  const LoanDashbord({super.key});

  @override
  State<LoanDashbord> createState() => _LoanDashbordState();
}

class _LoanDashbordState extends State<LoanDashbord> {
  List<Map<String, String>> pendingLoans = [];
  List<Map<String, String>> completedLoans = [];

  @override
  void initState() {
    super.initState();
    _loadLoans();
  }

  Future<void> _loadLoans() async {
    final prefs = await SharedPreferences.getInstance();
    final loanTypeString = prefs.getString('loanType') ?? '';
    LoanType.values.firstWhere(
      (e) => e.name == loanTypeString,
      orElse: () => LoanType.LoanGivenByMe,
    );
    setState(() {
      pendingLoans = [
        {
          'loanAmount': prefs.getString('loanAmount') ?? '',
          'loanName': prefs.getString('loanName') ?? '',
          'fullName': prefs.getString('fullName') ?? '',
          'incurredDate': prefs.getString('incurredDate') ?? '',
          'loanType': loanTypeString,
        }
      ];
      completedLoans = [
        {
          'loanAmount': prefs.getString('loanAmount') ?? '',
          'loanName': prefs.getString('loanName') ?? '',
          'fullName': prefs.getString('fullName') ?? '',
          'incurredDate': prefs.getString('incurredDate') ?? '',
          'loanType': loanTypeString,
        }
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Loan Dashbord',
          style: AppTheme.headerStyle(color: whiteColor),
        ),
        actions: [
          IconButton(onPressed: () {context.push('/search_loan');}, icon: const Icon(Icons.search))
        ],
        iconTheme: const IconThemeData(
          color: whiteColor, 
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Row(
                children: [
                  8.width(),
                  Text(
                    'Money Track',
                    style: AppTheme.headerStyle(color: whiteColor),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Loan Dashboard'),
              onTap: () {
                Navigator.pop(context);
                context.push('/loan_dashbord');
              },
            ),
            ListTile(
              title: const Text('Add Loan'),
              onTap: () {
                Navigator.pop(context);
                context.push('/add_loan');
              },
            ),
            ListTile(
              title: const Text('View Loan'),
              onTap: () {
                Navigator.pop(context);
                context.push('/view_loan');
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.pop(context);
                context.push('/privacy_policy');
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: greyColor),
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Loaned",
                                  style: AppTheme.headerStyle(),
                                ),
                              ),
                              const Icon(
                                Icons.outbond,
                                color: redColor,
                              )
                            ],
                          ),
                          Text(
                            '\$ 4500',
                            style: AppTheme.titleStyle(),
                          ),
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Owed",
                                  style: AppTheme.headerStyle(),
                                ),
                              ),
                              const Icon(
                                Icons.outbond,
                                color: greenColor,
                              )
                            ],
                          ),
                          Text(
                            '\$ 50000',
                            style: AppTheme.titleStyle(),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Total Balance",
                          style: AppTheme.headerStyle(),
                        ),
                        Text(
                          '\$ 45500',
                          style: AppTheme.titleStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            30.height(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pending Loan',
                  style: AppTheme.headerStyle(),
                ),
                15.height(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: pendingLoans.map((loan) {
                      return LoanInfoCard(
                        loanAmount: loan['loanAmount'] ?? '',
                        loanName: loan['loanName'] ?? '',
                        loanType: LoanType.values.firstWhere(
                          (e) => e.name == loan['loanType'],
                          orElse: () => LoanType.LoanGivenByMe,
                        ),
                        fullName: loan['fullName'] ?? '',
                        incurredDate: loan['incurredDate'] ?? '',
                        isLoaned: true,
                        onTap: () {
                          context.push('/view_loan');
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            30.height(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completed Loan',
                  style: AppTheme.headerStyle(),
                ),
                15.height(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: completedLoans.map((loan) {
                      return LoanInfoCard(
                        loanAmount: loan['loanAmount'] ?? '',
                        loanName: loan['loanName'] ?? '',
                        loanType: LoanType.values.firstWhere(
                          (e) => e.name == loan['loanType'],
                          orElse: () => LoanType.LoanGivenByMe,
                        ),
                        fullName: loan['fullName'] ?? '',
                        incurredDate: loan['incurredDate'] ?? '',
                        isLoaned: true,
                        onTap: () {
                          context.push('/view_loan');
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
