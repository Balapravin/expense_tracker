import 'package:tracker/bloc/add_expense/add_expense_bloc.dart';
import 'package:tracker/model/send_to_api/add_expense_model.dart';
import 'package:tracker/routes/index.dart';
import 'package:tracker/utils/tracker_path_export.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  void initState() {
    BlocProvider.of<AddExpenseBloc>(context).add(GetExpenseList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        appBarTitle: 'Expense List',
        floatingActionButtonOnTap: () {
          Navigator.pushNamed(context, PageRoutes.addExpense);
        },
        child: BlocConsumer<AddExpenseBloc, AddExpenseState>(
          listener: (context, state) {
            if (state is FcmAuthenticationLoadingState) {
            } else if (state is AddExpenseSuccess) {
              Logger.successPrint(
                  titleMessage: "success", printObject: state.successMessage);
              // Navigator.pushNamed(context, PageRoutes.expenseList,);
            } else if (state is AddExpenseFailed) {
              Logger.successPrint(titleMessage: state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is ExpenseListSuccess) {
              return state.expensesList.isEmpty
                  ? const Center(
                      child: Text("No Data", style: TextStyle(fontSize: 16, color: Colors.white),),
                    )
                  : ListView.builder(
                      itemCount: state.expensesList.length,
                      itemBuilder: (context, index) {
                        AddExpenseModel expense = state.expensesList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          color: Colors.white,
                          child: ListTile(
                            title: Text(expense.description!),
                            subtitle:
                                Text('${expense.category} - ${expense.date}'),
                            trailing: Text('\$${expense.amount.toString()}'),
                          ),
                        );
                      },
                    );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
