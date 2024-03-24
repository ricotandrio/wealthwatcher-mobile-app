class ExpenseDTO {
  final String type;
  final String name;
  final double amount;
  final String date;
  final String description;
  final String paidMethod;

  ExpenseDTO({
    required this.type,
    required this.name,
    required this.amount,
    required this.date,
    required this.description,
    required this.paidMethod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'name': name,
      'amount': amount,
      'date': date,
      'description': description,
      'paidMethod': paidMethod,
    };
  }

  factory ExpenseDTO.fromMap(Map<String, dynamic> map) {
    return ExpenseDTO(
      type: map['type'],
      name: map['name'],
      amount: map['amount'],
      date: map['date'],
      description: map['description'],
      paidMethod: map['paidMethod'],
    );
  }

  @override
  String toString() {
    return 'ExpenseDTO(type: $type, name: $name, amount: $amount, date: $date, description: $description, paidMethod: $paidMethod)';
  }
}