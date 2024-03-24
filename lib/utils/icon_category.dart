import 'package:flutter/material.dart';

class IconCategory {
  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'food':
        return Icons.fastfood;
      case 'transportation':
        return Icons.directions_bus;
      case 'entertainment':
        return Icons.local_movies;
      case 'clothing':
        return Icons.checkroom;
      case 'bills':
        return Icons.receipt;
      case 'shopping':
        return Icons.shopping_cart;
      case 'education':
        return Icons.school;
      case 'other':
        return Icons.redeem;
      default:
        return Icons.error;
    }
  }
}
