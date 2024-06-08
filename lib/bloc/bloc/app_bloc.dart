// import 'package:customer_application/bloc/bloc/app_event.dart';
// import 'package:customer_application/bloc/bloc/app_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class splashBloc extends Bloc<SplashEvent, splashState> {
//   splashBloc() : super(splashInitial()){
//     on<StartSplash>(_onstartSplash);
//   }

//   Future<void> _onstartSplash(StartSplash event,Emitter<splashState> emit) async {
//     emit(splashLoading());
//     await Future.delayed(Duration(seconds: 3));
//     emit(splashLoaded());
//   }
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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



    on<SignupEvent>(((event, emit) async {
      emit(AuthLoading());

      try{
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.user!.email.toString(), 
          password: event.user!.password.toString());

          final user=userCredential.user;

          if(user != null){
            FirebaseFirestore.instance.collection("users").doc(user.uid).set({
              'uid':user.uid,
              'email':user.email,
              'name':event.user.name,
              'createdAt':DateTime.now()
            });
            emit(Authenticated(user));
          }else{
            emit(UnAuthenticated());
          }
      }catch(e){
        emit(AuthenticatedError(message: e.toString()));
      }
    }));

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
  }
}