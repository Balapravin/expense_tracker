import 'package:tracker/bloc/add_expense/add_expense_bloc.dart';
import 'package:tracker/routes/index.dart';
import 'package:tracker/utils/tracker_path_export.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}
///Add Expenses:
/// Users should be able to add expenses with details such as amount, description, category, and date.
///
/// amount
/// description
/// category
/// date
class _AddExpenseState extends State<AddExpense> {
  final formKey = GlobalKey<FormState>();
  TextEditingController amountTextEditingController =TextEditingController();
  TextEditingController descriptionTextEditingController =TextEditingController();
  TextEditingController categoryTextEditingController =TextEditingController();
  TextEditingController dateTextEditingController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child:
              BlocListener<AddExpenseBloc, AddExpenseState>(
                listener: (context, state) {
                  if (state is FcmAuthenticationLoadingState) {
                  } else if (state is AddExpenseSuccess) {
                    Logger.successPrint(
                        titleMessage: "success",
                        printObject: state.successMessage);
                    Navigator.pushNamed(context, PageRoutes.expenseList,);
                  } else if (state is AddExpenseFailed) {
                    Logger.successPrint(titleMessage: state.errorMessage);

                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Flexible(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Add Expense",
                                style: TrackerTextStyles.kHeadlineLarge,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              MyTextField(
                                controller: amountTextEditingController,
                                hintText: 'Enter Amount',
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.number,
                              ),

                              MyTextField(
                                controller: categoryTextEditingController,
                                hintText: 'Enter Category',
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.emailAddress,
                              ),

                              MyTextField(
                                onTap: () async {
                                  await _selectDate(context);
                                },
                                controller: dateTextEditingController,
                                hintText: 'Enter DateText',
                                inputType: TextInputType.none,
                              ),
                              MyTextField(
                                maxLength: 500,
                                maxLines: 3,
                                controller: descriptionTextEditingController,
                                hintText: 'Enter Description',
                                autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                                inputType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TrackerConstWidget.kSizeBox20,
                      MyTextButton(
                        buttonName: 'Add Expense',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AddExpenseBloc>(context)
                                .add(ToAddExpense(amount: amountTextEditingController.text, category:categoryTextEditingController.text, date: dateTextEditingController.text, description:descriptionTextEditingController.text
                            ));
                          }
                        },
                        bgColor: Colors.white,
                        textColor: Colors.black87,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateTextEditingController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

}
//// bloc/expense_state.dart
// import 'package:equatable/equatable.dart';
// import '../models/expense.dart';
//
// abstract class ExpenseState extends Equatable {
//   const ExpenseState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class ExpenseInitial extends ExpenseState {}
//
// class ExpenseLoading extends ExpenseState {}
//
// class ExpenseLoaded extends ExpenseState {
//   final List<Expense> expenses;
//
//   const ExpenseLoaded(this.expenses);
//
//   @override
//   List<Object> get props => [expenses];
// }
//
// class ExpenseError extends ExpenseState {
//   final String message;
//
//   const ExpenseError(this.message);
//
//   @override
//   List<Object> get props => [message];
// }
