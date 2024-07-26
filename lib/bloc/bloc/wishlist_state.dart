// wishlist_state.dart

import 'package:equatable/equatable.dart';

class WishlistState extends Equatable {
  final List<Map<String, dynamic>> wishlist;

  const WishlistState({this.wishlist = const []});

  @override
  List<Object> get props => [wishlist];
}
