
// ignore_for_file: unused_import

import 'package:customer_application/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}


class AuthInitial extends  AuthState{

}

class AuthLoading extends AuthState{}


class Authenticated extends AuthState{

  User? user;
  Authenticated(this.user);
}

class UnAuthenticated extends AuthState{}

class AuthenticatedError extends AuthState{

  final String message;

  AuthenticatedError({required this.message});

}
