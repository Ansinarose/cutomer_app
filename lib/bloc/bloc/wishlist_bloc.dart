// wishlist_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  WishlistBloc() : super(WishlistState()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<AddToWishlist>(_onAddToWishlist);
    on<RemoveFromWishlist>(_onRemoveFromWishlist);
  }

  void _onLoadWishlist(LoadWishlist event, Emitter<WishlistState> emit) async {
    try {
      final QuerySnapshot snapshot = await firestore.collection('wishlist').get();
      final wishlist = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      emit(WishlistState(wishlist: wishlist));
    } catch (e) {
      print('Failed to load wishlist: $e');
    }
  }

  void _onAddToWishlist(AddToWishlist event, Emitter<WishlistState> emit) async {
    try {
      final docRef = await firestore.collection('wishlist').add(event.product);
      final updatedWishlist = List<Map<String, dynamic>>.from(state.wishlist)
        ..add(event.product..['id'] = docRef.id);
      emit(WishlistState(wishlist: updatedWishlist));
    } catch (e) {
      print('Failed to add to wishlist: $e');
    }
  }

  void _onRemoveFromWishlist(RemoveFromWishlist event, Emitter<WishlistState> emit) async {
    try {
      await firestore.collection('wishlist').doc(event.productId).delete();
      final updatedWishlist = state.wishlist.where((product) => product['id'] != event.productId).toList();
      emit(WishlistState(wishlist: updatedWishlist));
    } catch (e) {
      print('Failed to remove from wishlist: $e');
    }
  }
}
