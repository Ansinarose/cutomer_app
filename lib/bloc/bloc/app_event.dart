// lib/bloc/splash_event.dart
import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
  
  @override
  List<Object> get props => [];
}

class StartSplash extends SplashEvent {}