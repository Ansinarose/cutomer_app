// wishlist_screen.dart

import 'package:customer_application/bloc/bloc/wishlist_bloc.dart';
import 'package:customer_application/bloc/bloc/wishlist_state.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/features/category/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        backgroundColor: AppColors.textPrimaryColor,
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state.wishlist.isEmpty) {
            return Center(child: Text('No items in the wishlist'));
          }
          return ListView.builder(
            itemCount: state.wishlist.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> product = state.wishlist[index];
              return Card(
                child: ListTile(
                  leading: Image.network(product['imageUrl'] ?? 'assets/images/default_image.png'),
                  title: Text(product['title'] ?? 'Unnamed Product'),
                  subtitle: Text('\₹${product['price'] ?? 'N/A'}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
