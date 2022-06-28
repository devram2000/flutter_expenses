import 'package:flutter/foundation.dart';

class Expense {
  final int id;
  final double cost;
  final String note;
  final DateTime date;

  Expense({
    required this.id,
    required this.cost,
    required this.note,
    required this.date,
  });
}
