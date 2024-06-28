part of 'fcm_authentication_bloc.dart';

abstract class FcmAuthenticationEvent {}

class FcmAuthenticationRegistrationEvent extends FcmAuthenticationEvent {
  final String name;
  final String email;
  final String password;

  FcmAuthenticationRegistrationEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class FcmSetUserDataEvent extends FcmAuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final User? userDetails;

  FcmSetUserDataEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.userDetails,
  });
}

class FcmAuthenticationLoginEvent extends FcmAuthenticationEvent {
  final String email;
  final String password;

  FcmAuthenticationLoginEvent({required this.email, required this.password});
}

class FcmAuthenticationLogoutEvent extends FcmAuthenticationEvent {}
