import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text_form_field/flutter_text_form_field.dart';
import 'package:manage_loan/config/extension.dart';
import 'package:manage_loan/enum/enums.dart';
import 'package:manage_loan/shared/utils/pick_file.dart';
import 'package:manage_loan/shared/widgets/custom_button.dart';
import 'package:manage_loan/shared/widgets/date_picker.dart';
import 'package:manage_loan/styles/colors.dart';
import 'package:manage_loan/styles/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLoanScreen extends StatefulWidget {
  const AddLoanScreen({super.key});

  @override
  State<AddLoanScreen> createState() => _AddLoanScreenState();
}

class _AddLoanScreenState extends State<AddLoanScreen> {
  Currency? currency;
  final currentDate = DateTime.now();

  LoanType? _selectedLoanType;
  final TextEditingController _loanNameController = TextEditingController();
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _incurredDateController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _loanNameController.dispose();
    _loanAmountController.dispose();
    _incurredDateController.dispose();
    _dueDateController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveLoanData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loanName', _loanNameController.text);
    await prefs.setString('loanAmount', _loanAmountController.text);
    await prefs.setString('loanCurrency', currency?.code ?? '');
    await prefs.setString('incurredDate', _incurredDateController.text);
    await prefs.setString('dueDate', _dueDateController.text);
    await prefs.setString('fullName', _fullNameController.text);
    await prefs.setString('phoneNumber', _phoneNumberController.text);
    await prefs.setString('loanType', _selectedLoanType?.name ?? '');
  }

  bool _isFormValid() {
    return _loanNameController.text.isNotEmpty &&
        _loanAmountController.text.isNotEmpty &&
        _incurredDateController.text.isNotEmpty &&
        _dueDateController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _selectedLoanType != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Add Loan', style: AppTheme.headerStyle(color: whiteColor)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loan Name',
                  style: AppTheme.headerStyle(),
                ),
                8.height(),
                CustomTextField(
                  _loanNameController,
                  hint: 'Loan Name',
                  password: false,
                  border: Border.all(color: greyColor),
                ),
                20.height(),
                Text(
                  'Loan Type',
                  style: AppTheme.headerStyle(),
                ),
                RadioListTile<LoanType>(
                  value: LoanType.LoanGivenByMe,
                  groupValue: _selectedLoanType,
                  activeColor: primaryColor,
                  title: const Text('Giving out a loan'),
                  onChanged: (value) {
                    setState(() {
                      _selectedLoanType = value;
                    });
                  },
                ),
                RadioListTile<LoanType>(
                  value: LoanType.LoanOwedByMe,
                  groupValue: _selectedLoanType,
                  activeColor: primaryColor,
                  title: const Text('Taking a loan'),
                  onChanged: (value) {
                    setState(() {
                      _selectedLoanType = value;
                    });
                  },
                ),
                20.height(),
                Text("Loan Document (optional)", style: AppTheme.headerStyle()),
                8.height(),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        pickDocument().then((value) {
                          if (value != null) {}
                        });
                      },
                      child: Text(
                        'Upload Document (pdf,image)',
                        style: AppTheme.titleStyle(color: primaryColor),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.check_circle,
                      color: greenColor,
                    )
                  ],
                ),
                20.height(),
                Row(
                  children: [
                    Text("Loan Amount", style: AppTheme.headerStyle()),
                    const Spacer(),
                    Text("Loan Currency", style: AppTheme.headerStyle()),
                  ],
                ),
                8.height(),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        _loanAmountController,
                        hint: 'Loan Amount',
                        keyboardType: TextInputType.number,
                        password: false,
                        border: Border.all(color: greyColor),
                      ),
                    ),
                    30.width(),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showCurrencyPicker(
                            context: context,
                            onSelect: (Currency value) {
                              currency = value;
                              setState(() {});
                            },
                            showCurrencyCode: true,
                            showCurrencyName: true,
                          );
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: greyColor),
                          ),
                          child: Text(currency == null
                              ? "Currency"
                              : "${currency!.code}-${currency!.symbol}"),
                        ),
                      ),
                    )
                  ],
                ),
                20.height(),
                Row(
                  children: [
                    Text("Incurred Date", style: AppTheme.headerStyle()),
                    const Spacer(),
                    Text("Due Date", style: AppTheme.headerStyle()),
                  ],
                ),
                8.height(),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        _incurredDateController,
                        hint: 'Incurred Date',
                        onTap: () async {
                          final date = await pickDate(
                            context,
                            firstDate: DateTime(currentDate.year - 1),
                            secondDate: currentDate,
                          );
                          if (date != null) {
                            _incurredDateController.text =
                                "${date.day}-${date.month}-${date.year}";
                          }
                        },
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        password: false,
                        border: Border.all(color: greyColor),
                      ),
                    ),
                    30.width(),
                    Expanded(
                      child: CustomTextField(
                        _dueDateController,
                        hint: 'Due Date',
                        onTap: () async {
                          final date = await pickDate(
                            context,
                            firstDate: DateTime(2000),
                            secondDate: DateTime(2100),
                          );
                          if (date != null) {
                            _dueDateController.text =
                                "${date.day}-${date.month}-${date.year}";
                          }
                        },
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        password: false,
                        border: Border.all(color: greyColor),
                      ),
                    ),
                  ],
                ),
                20.height(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Creditor's details",
                      style: AppTheme.headerStyle(),
                    ),
                    10.height(),
                    Text(
                      "Full Name",
                      style: AppTheme.headerStyle(),
                    ),
                    8.height(),
                    CustomTextField(
                      _fullNameController,
                      hint: 'Full Name',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    10.height(),
                    Text(
                      "Phone Number",
                      style: AppTheme.headerStyle(),
                    ),
                    8.height(),
                    CustomTextField(
                      _phoneNumberController,
                      hint: 'Phone Number',
                      password: false,
                      border: Border.all(color: greyColor),
                    ),
                    40.height(),
                    CustomButton(
                      onPressed: () async {
                        if (_isFormValid()) {
                          await _saveLoanData();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Your request has been sent correctly.')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please fill all required fields.')),
                          );
                        }
                      },
                      text: 'Send Request',
                    ),
                    40.height(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
