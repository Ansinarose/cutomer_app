// ignore_for_file: unused_import

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends HomeEvent {
  final String serviceId;

  const FetchCategoriesEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}

class SearchCategoriesEvent extends HomeEvent {
  final String query;

  const SearchCategoriesEvent(this.query);

  @override
  List<Object> get props => [query];
}