// lib/bloc/splash_event.dart
import 'package:customer_application/features/auth/models/user_model.dart';

abstract class AuthEvent {}



class CheckLoginStatusEvent extends AuthEvent{}

//login evnt

class LoginEvent extends AuthEvent{
 final String email;
 final String password;

 LoginEvent({required this.email,required this.password});

}

//signup event

class SignupEvent extends AuthEvent{
  final UserModel user;

  SignupEvent({required this.user});
}

class LogoutEvent extends AuthEvent{}

class GoogleSignInEvent extends AuthEvent {}

class FetchUserProfileEvent extends AuthEvent {}