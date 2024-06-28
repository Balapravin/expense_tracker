// To parse this JSON data, do
//
//     final userRegistrationModel = userRegistrationModelFromJson(jsonString);

import 'dart:convert';

UserRegistrationModel userRegistrationModelFromJson(String str) =>
    UserRegistrationModel.fromJson(json.decode(str));

String userRegistrationModelToJson(UserRegistrationModel data) =>
    json.encode(data.toJson());

class UserRegistrationModel {
  final String? userName;
  final String? emailId;
  final String? password;
  final String? mobileNumber;
  final String? userImageUrl;
  final String? fcmToken;

  UserRegistrationModel({
    this.userName,
    this.emailId,
    this.password,
    this.mobileNumber,
    this.userImageUrl,
    this.fcmToken,
  });

  factory UserRegistrationModel.fromJson(Map<String, dynamic> json) =>
      UserRegistrationModel(
        userName: json["user_name"],
        emailId: json["email_id"],
        password: json["password"],
        mobileNumber: json["mobile_number"],
        userImageUrl: json["user_image_url"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "email_id": emailId,
        "password": password,
        "mobile_number": mobileNumber,
        "user_image_url": userImageUrl,
        "fcm_token": fcmToken,
      };
}
