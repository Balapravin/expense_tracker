import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tracker/model/send_to_api/add_expense_model.dart';
import 'package:tracker/utils/tracker_path_export.dart';

part 'add_expense_event.dart';
part 'add_expense_state.dart';

class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  AddExpenseBloc() : super(AddExpenseInitial()) {
    on<ToAddExpense>(_toAddExpense);
    on<GetExpenseList>(_getExpenseList);
    on<FilterExpensesEvent>(_onFilterExpenses);
  }

  Future<void> _toAddExpense(
      ToAddExpense event, Emitter<AddExpenseState> emit) async {
    try {
      // Construct user data model
      AddExpenseModel expenseData = AddExpenseModel(
        uid: FirebaseAuth.instance.currentUser?.uid,
        amount: event.amount,
        description: event.description,
        category: event.category,
        date: event.date,
      );

      // Save user data to Firestore
      final userDb = FirebaseFirestore.instance.collection("expense");

      await userDb.add(expenseData.toJson()).then((value) {
        emit(AddExpenseSuccess("SUCCESS"));
      });
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      emit(AddExpenseFailed(e.code));
    } catch (e) {
      // Handle other exceptions
      emit(AddExpenseFailed(e.toString()));
    }
  }

  Future<void> _getExpenseList(
      GetExpenseList event, Emitter<AddExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('expense')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      List<AddExpenseModel> expenses = querySnapshot.docs.map((doc) {
        return AddExpenseModel.fromFirestore(doc);
      }).toList();

      emit(ExpenseListSuccess(expenses));
    } catch (e) {
      Logger.errorPrint(printObject: e);
      emit(ExpenseListFailed(e.toString()));
    }
  }

  Future<void> _onFilterExpenses(
      FilterExpensesEvent event, Emitter<AddExpenseState> emit) async {
    emit(ExpenseLoading());
    try {
      Query query = FirebaseFirestore.instance
          .collection('expense')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

      if (event.startDate != null) {
        query = query.where('date', isGreaterThanOrEqualTo: event.startDate);
      }
      if (event.endDate != null) {
        query = query.where('date', isLessThanOrEqualTo: event.endDate);
      }
      if (event.category != null && event.category!.isNotEmpty) {
        query = query.where('category', isEqualTo: event.category);
      }
      if (event.minAmount != null) {
        query = query.where('amount', isGreaterThanOrEqualTo: event.minAmount);
      }
      if (event.maxAmount != null) {
        query = query.where('amount', isLessThanOrEqualTo: event.maxAmount);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<AddExpenseModel> expenses = querySnapshot.docs.map((doc) {
        return AddExpenseModel.fromFirestore(doc);
      }).toList();

      emit(ExpenseListSuccess(expenses));
    } catch (e) {
      emit(ExpenseListFailed(e.toString()));
    }
  }
}
