abstract class Management {
  String category;
  String name;
  double amount;
  String date;
  String? description;
  String paidMethod;

  Management({
    required this.category,
    required this.name,
    required this.amount,
    required this.date,
    this.description,
    required this.paidMethod,
  });
}
