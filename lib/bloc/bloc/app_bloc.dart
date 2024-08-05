
// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/features/auth/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn=GoogleSignIn();


  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatusEvent>((event, emit) async{
  User? user;
   try{
    
 await Future.delayed(Duration(seconds: 2),(){
    user=_auth.currentUser;
      });
  if(user != null){
    emit(Authenticated(user));
  }else{
    emit(UnAuthenticated());
  }
   }catch(e){
    emit(AuthenticatedError(message: e.toString()));
   }

    });



    // on<SignupEvent>(((event, emit) async {
    //   emit(AuthLoading());

    //   try{
    //     final userCredential = await _auth.createUserWithEmailAndPassword(
    //       email: event.user.email.toString(), 
    //       password: event.user.password.toString());

    //       final user=userCredential.user;

    //       if(user != null){
    //         FirebaseFirestore.instance.collection("customer").doc(user.uid).set({
    //           'uid':user.uid,
    //           'email':user.email,
    //           'name':event.user.name,
    //           'createdAt':DateTime.now()
    //         });
    //         emit(Authenticated(user));
    //       }else{
    //         emit(UnAuthenticated());
    //       }
    //   }catch(e){
    //     emit(AuthenticatedError(message: e.toString()));
    //   }
    // }));
    on<SignupEvent>((event, emit) async {
  emit(AuthLoading());
  try {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: event.user.email.toString(),
      password: event.user.password.toString(),
    );
    final user = userCredential.user;
    if (user != null) {
      await FirebaseFirestore.instance.collection("customer").doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': event.user.name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      emit(Authenticated(user));
    } else {
      emit(UnAuthenticated());
    }
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'invalid-email':
        emit(AuthenticatedError(message: 'The email address is badly formatted.'));
        break;
      case 'email-already-in-use':
        emit(AuthenticatedError(message: 'The email address is already in use by another account.'));
        break;
      case 'weak-password':
        emit(AuthenticatedError(message: 'The password provided is too weak.'));
        break;
      default:
        emit(AuthenticatedError(message: e.message ?? 'An error occurred during signup'));
    }
  } catch (e) {
    emit(AuthenticatedError(message: 'An unexpected error occurred'));
  }
});

    on<LoginEvent>(((event, emit)  async{
      
      emit(AuthLoading());
      try{

        final userCredential= await _auth.signInWithEmailAndPassword(email: event.email, password: event.password);

        final user=userCredential.user;
        if(user != null){
          emit(Authenticated(user));
        }else{
          emit(UnAuthenticated());
        }
      }catch(e){
        emit(AuthenticatedError(message: e.toString()));
      }

    }));


    on<LogoutEvent>((event, emit) async{
      
      try{
        await _auth.signOut();
        emit(UnAuthenticated());
      }catch(e){
        emit(AuthenticatedError(message: e.toString()));
      }
    });



    
    on<GoogleSignInEvent>((event, emit) async {
  emit(AuthLoading());
  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    } else {
      emit(UnAuthenticated());
    }
  } catch (e) {
    // Log the error for debugging purposes
    print('Google Sign-In Error: $e');
    emit(AuthenticatedError(message: e.toString()));
  }
});


}
}
