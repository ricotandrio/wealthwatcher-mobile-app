import 'dart:convert';

import 'package:wealthwatcher/models/expense_dto.dart';

class GetAllExpenseOutput {
  final List<ExpenseDTO> data;

  GetAllExpenseOutput({
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((expense) => expense.toMap()).toList(),
    };
  }

  factory GetAllExpenseOutput.fromMap(Map<String, dynamic> map) {
    return GetAllExpenseOutput(
      data: List<ExpenseDTO>.from(
        map['data'].map((expense) => ExpenseDTO.fromMap(expense)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAllExpenseOutput.fromJson(String source) =>
      GetAllExpenseOutput.fromMap(json.decode(source));

}