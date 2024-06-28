import 'package:tracker/screens/add_expense.dart';
import 'package:tracker/screens/expense_list.dart';
import 'package:tracker/utils/tracker_path_export.dart';

class PageRoutes{
  static const String register = "/register";
  static const String signInPage = "/details";
  static const String addExpense = "/addExpense";
  static const String expenseList = "/expenseList";

  defaultRoute() {
    return signInPage;
  }
  Map<String, WidgetBuilder> routes() {
    return {
      register: (context) => const RegisterPage(),
      signInPage: (context) => SignInPage(),
      addExpense: (context) => const AddExpense(),
      expenseList: (context) => const ExpenseList(),
    };
  }
}