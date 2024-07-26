import 'package:customer_application/bloc/cart_event.dart';
import 'package:customer_application/bloc/cart_state.dart';
import 'package:customer_application/features/cart/views/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_application/bloc/cart_bloc.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/category/views/product_details.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: AppColors.textPrimaryColor,
              automaticallyImplyLeading: false,
              actions: [
    IconButton(
      icon: Icon(Icons.favorite, color: Colors.white),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WishlistScreen()),
        );
      },
    ),
  ],
            ),
            Positioned(
              top: 100,
              left: 16,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: Text(
                    'My Cart',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  
                ),
              ),
            ),
            Positioned(
              top: 90,
              child: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(child: Text('Your cart is empty', style: AppTextStyles.body));
            }
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final product = state.items[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: product['imageUrl'] != null
                                      ? NetworkImage(product['imageUrl'])
                                      : AssetImage('assets/images/default_image.png') as ImageProvider,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle_outline, color: AppColors.textPrimaryColor),
                                onPressed: () {
                                  context.read<CartBloc>().add(RemoveFromCartEvent(product));
                                },
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'] ?? 'Unnamed Product',
                                  style: AppTextStyles.body,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\₹${product['price'] ?? 'N/A'}',
                                  style: TextStyle(
                                    color: AppColors.textPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 4),
                                Expanded(
                                  child: Text(
                                    product['description'] ?? 'No description available',
                                    style: TextStyle(color: Colors.grey[600]),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}