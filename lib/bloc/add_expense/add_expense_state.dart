part of 'add_expense_bloc.dart';

abstract class AddExpenseState {}

final class AddExpenseInitial extends AddExpenseState {}

final class AddExpenseSuccess extends AddExpenseState {
  final String successMessage;
  AddExpenseSuccess(this.successMessage);

}

final class AddExpenseFailed extends AddExpenseState {
  final String errorMessage;

  AddExpenseFailed(this.errorMessage);
}

final class ExpenseLoading extends AddExpenseState {}
final class ExpenseListSuccess extends AddExpenseState {
  final  List<AddExpenseModel> expensesList;
  ExpenseListSuccess(this.expensesList);
}

final class ExpenseListFailed extends AddExpenseState {
  final String errorMessage;
  ExpenseListFailed(this.errorMessage);
}
//