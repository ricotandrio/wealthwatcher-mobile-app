class Expense {
  String id;
  String category;
  String name;
  double amount;
  String date;
  String description;
  String paidMethod;

  Expense({
    required this.id,
    required this.category,
    required this.name,
    required this.amount,
    required this.date,
    required this.description,
    required this.paidMethod,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      name: json['name'],
      amount: json['amount'].toDouble(),
      date: json['date'].toDateTime(),
      description: json['description'],
      paidMethod: json['paid_method'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['description'] = this.description;
    data['paid_method'] = this.paidMethod;
    return data;
  }
}
