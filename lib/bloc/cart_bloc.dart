import 'dart:convert';

import 'package:customer_application/bloc/cart_event.dart';
import 'package:customer_application/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Map<String, dynamic>> _cartItems = [];

  CartBloc() : super(CartInitial()) {
    on<LoadCartEvent>((event, emit) async {
      await _loadCartFromPrefs();
      emit(CartLoaded(_cartItems));
    });

    on<AddToCartEvent>((event, emit) async {
      _cartItems.add(event.product);
      await _saveCartToPrefs();
      emit(CartLoaded(_cartItems));
    });

    on<RemoveFromCartEvent>((event, emit) async {
      _cartItems.remove(event.product);
      await _saveCartToPrefs();
      emit(CartLoaded(_cartItems));
    });

    // Load cart items when the bloc is initialized
    add(LoadCartEvent());
  }

  Future<void> _saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(_cartItems);
    await prefs.setString('cart_items', encodedData);
  }

  Future<void> _loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('cart_items');
    if (encodedData != null) {
      final List<dynamic> decodedData = json.decode(encodedData);
      _cartItems = decodedData.cast<Map<String, dynamic>>();
    }
  }
}