import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Map<String, dynamic> product;
  AddToCartEvent(this.product);
}

class RemoveFromCartEvent extends CartEvent {
  final Map<String, dynamic> product;
  RemoveFromCartEvent(this.product);
}
class LoadCartEvent extends CartEvent {}
