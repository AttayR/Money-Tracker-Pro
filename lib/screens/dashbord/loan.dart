class Loan {
  String loanName;
  String loanAmount;
  String loanCurrency;
  String incurredDate;
  String dueDate;
  String fullName;
  String phoneNumber;
  bool isCompleted;

  Loan({
    required this.loanName,
    required this.loanAmount,
    required this.loanCurrency,
    required this.incurredDate,
    required this.dueDate,
    required this.fullName,
    required this.phoneNumber,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'loanName': loanName,
      'loanAmount': loanAmount,
      'loanCurrency': loanCurrency,
      'incurredDate': incurredDate,
      'dueDate': dueDate,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'isCompleted': isCompleted,
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      loanName: map['loanName'],
      loanAmount: map['loanAmount'],
      loanCurrency: map['loanCurrency'],
      incurredDate: map['incurredDate'],
      dueDate: map['dueDate'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
