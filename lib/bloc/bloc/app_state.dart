// part of 'app_bloc.dart';

// @immutable
// sealed class AppState {}

// final class AppInitial extends AppState {}

import 'package:equatable/equatable.dart';

abstract class splashState extends Equatable{
  const splashState();

  @override

  List<Object> get props => [];

}

class splashInitial extends splashState{}

class splashLoading extends splashState{}

class splashLoaded extends splashState{}