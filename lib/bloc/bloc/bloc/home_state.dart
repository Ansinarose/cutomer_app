part of 'home_bloc.dart';
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Map<String, dynamic>> categories;
  final String searchQuery;

  const HomeLoaded({required this.categories, this.searchQuery = ''});

  @override
  List<Object> get props => [categories, searchQuery];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

