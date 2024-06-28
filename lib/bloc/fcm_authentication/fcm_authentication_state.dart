part of 'fcm_authentication_bloc.dart';

abstract class FcmAuthenticationState {}

class FcmAuthenticationInitialState extends FcmAuthenticationState {}

class FcmAuthenticationLoadingState extends FcmAuthenticationState {}

class FcmRegistrationSuccessState extends FcmAuthenticationState {
  final User user;

  FcmRegistrationSuccessState({required this.user});
}

class FcmLoginSuccessState extends FcmAuthenticationState {
  final User user;

  FcmLoginSuccessState({required this.user});
}

class FcmAuthenticationLogoutSuccessState extends FcmAuthenticationState {
  final String logoutMessage;

  FcmAuthenticationLogoutSuccessState({required this.logoutMessage});
}

class FcmSetUserDataSuccessState extends FcmAuthenticationState {
  final String successMessage;

  FcmSetUserDataSuccessState({required this.successMessage});
}

class FcmAuthenticationFailedState extends FcmAuthenticationState {
  final String errorMessage;

  FcmAuthenticationFailedState({required this.errorMessage});
}

class FcmAuthenticationExceptionState extends FcmAuthenticationState {
  final String exceptionErrorMessage;

  FcmAuthenticationExceptionState({required this.exceptionErrorMessage});
}
