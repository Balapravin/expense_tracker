import 'dart:convert';

import 'package:tracker/utils/tracker_path_export.dart';

AddExpenseModel AddExpenseModelFromJson(String str) =>
    AddExpenseModel.fromJson(json.decode(str));

String AddExpenseModelToJson(AddExpenseModel data) =>
    json.encode(data.toJson());

class AddExpenseModel {
  final String? userName;
  final String? uid;
  final String? amount;
  final String? description;
  final String? category;
  final String? date;

  AddExpenseModel({
    this.userName,
    this.uid,
    this.amount,
    this.description,
    this.category,
    this.date,
  });

  factory AddExpenseModel.fromJson(Map<String, dynamic> json) =>
      AddExpenseModel(
        userName: json["user_name"],
        uid: json["uid"],
        amount: json["amount"],
        description: json["description"],
        category: json["category"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "uid": uid,
    "amount": amount,
    "description": description,
    "category": category,
    "date": date,
  };
  factory AddExpenseModel.fromFirestore(DocumentSnapshot doc) {
    Map json = doc.data() as Map;
    return  AddExpenseModel(
      userName: json["user_name"],
      uid: json["uid"],
      amount: json["amount"],
      description: json["description"],
      category: json["category"],
      date: json["date"],
    );
  }
}
