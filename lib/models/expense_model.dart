// enumm for expense catogory

import 'dart:ui';

enum ExpenseCategory { food, transport, health, shopping, subscription }

// category images

final Map<ExpenseCategory, String> expenseCategoryImages = {
  ExpenseCategory.food: "aassets/images/restaurant.png",
  ExpenseCategory.transport: "assets/images/car.png",
  ExpenseCategory.health: "assets/images/health.png",
  ExpenseCategory.shopping: "assets/images/bag.png",
  ExpenseCategory.subscription: "assets/images/bill.png",
};

// category colors

final Map<ExpenseCategory, Color> expenseCategoryColor = {
  ExpenseCategory.food: const Color(0xFFE57373),
  ExpenseCategory.transport: const Color(0xFF81C784),
  ExpenseCategory.health: const Color(0xFF64B5F6),
  ExpenseCategory.shopping: const Color(0xFFFFD54F),
  ExpenseCategory.subscription: const Color(0xFF9575CD),
};

class ExpenseModel {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  // Convert model to JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  // Convert JSON to model safely
  factory ExpenseModel.fromJSON(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? "",
      amount: (json['amount'] is String)
          ? double.tryParse(json['amount']) ?? 0
          : (json['amount'] as num).toDouble(),
      category: ExpenseCategory.values[json['category'] ?? 0],
      date: DateTime.tryParse(json['date'] ?? "") ?? DateTime.now(),
      time: DateTime.tryParse(json['time'] ?? "") ?? DateTime.now(),
      description: json['description']?.toString() ?? "",
    );
  }
}



