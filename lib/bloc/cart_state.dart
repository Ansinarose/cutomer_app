abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Map<String, dynamic>> items;
  CartLoaded(this.items);
}