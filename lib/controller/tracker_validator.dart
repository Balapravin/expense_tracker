import 'package:tracker/utils/tracker_path_export.dart';

class TrackerValidator {
  static String? validateName({required String? name}) {
    if (name == null || name.trim().isEmpty) {
      return 'Name can\'t be empty';
    } else if (name.trim().length < 3) {
      return 'Enter a password with length at least 3';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email == null || email.trim().isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a correct email';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null || password.trim().isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 8) {
      return 'Enter a password length at least 8';
    }

    return null;
  }

  static String? validatePhone({required String? phoneNumber}) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return 'Password can\'t be empty';
    } else if (phoneNumber.length < 10) {
      // For India Only
      return 'Enter a phone number required must 10 digit';
    }

    return null;
  }

  static String? passwordValidator(
      {required String? password, required String? conformPassword}) {
    if (password == null || password.trim().isEmpty) {
      return "Password required for evaluation";
    } else if (conformPassword == null || conformPassword.trim().isEmpty) {
      return 'Confirm Password can\'t be empty';
    } else if (password != conformPassword) {
      Logger.successPrint(titleMessage: password != conformPassword);
      return "Confirm Password must match with Password";
    }
    return null;
  }
}
