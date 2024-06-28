part of 'add_expense_bloc.dart';

abstract class AddExpenseEvent {}

class ToAddExpense extends AddExpenseEvent {
  final String amount;
  final String category;
  final String description;
  final String date;
  ToAddExpense(
      {required this.amount,
      required this.category,
      required this.date,
      required this.description});
}

class GetExpenseList extends AddExpenseEvent {}

class FilterExpensesEvent extends AddExpenseEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? category;
  final double? minAmount;
  final double? maxAmount;

   FilterExpensesEvent(
      {this.startDate,
      this.endDate,
      this.category,
      this.minAmount,
      this.maxAmount});
}
