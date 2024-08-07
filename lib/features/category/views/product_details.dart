import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/bloc/cart_bloc.dart';
import 'package:customer_application/bloc/cart_event.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/widgets/review_list.dart';
import 'package:customer_application/features/booking/views/booking_screen.dart';
import 'package:customer_application/features/cart/views/cart_screen.dart';
import 'package:customer_application/features/review/view/review_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final bookingId;

  const ProductDetailsScreen({Key? key, required this.product, this.bookingId}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = (screenWidth - 48) / 2; // 48 accounts for padding and spacing

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['title'],
                    style: AppTextStyles.subheading,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 120,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: (widget.product['additionalImages'].length / 2).ceil(),
                      itemBuilder: (context, pageIndex) {
                        return Row(
                          children: [
                            for (int i = 0; i < 2; i++)
                              if (pageIndex * 2 + i < widget.product['additionalImages'].length)
                                Padding(
                                  padding: EdgeInsets.only(right: i == 0 ? 8.0 : 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      widget.product['additionalImages'][pageIndex * 2 + i],
                                      height: 120,
                                      width: imageWidth,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: (widget.product['additionalImages'].length / 2).ceil(),
                      effect: WormEffect(
                        dotColor: Colors.grey.shade300,
                        activeDotColor: AppColors.textPrimaryColor,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: AppTextStyles.subheading,
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.product['description'],
                    style: AppTextStyles.body,
                  ),
                  SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price: \₹${widget.product['price']}',
                              style: AppTextStyles.subheading.copyWith(
                                color: AppColors.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Overview:',
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              widget.product['overview'],
                              style: AppTextStyles.body,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Available Colors:',
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: (widget.product['colors'] as List<dynamic>).map((color) => Chip(
                                label: Text(color, style: TextStyle(color: AppColors.textPrimaryColor)),
                                backgroundColor: AppColors.textsecondaryColor,
                                side: BorderSide(color: AppColors.textPrimaryColor),
                              )).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 20),
                  Text('Customer Reviews', style: AppTextStyles.subheading),
                  SizedBox(height: 10),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('customerreviews')
                        .where('productId', isEqualTo: widget.product['productId'])
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      print('Product ID for reviews: ${widget.product['productId']}'); // Add this line for debugging
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        print('Error in reviews: ${snapshot.error}'); // Add this line for debugging
                        return Text('Error loading reviews: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('No reviews yet for this product.');
                      }

                      print('Number of reviews: ${snapshot.data!.docs.length}'); // Add this line for debugging

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display only the first 2 reviews
                          for (int i = 0; i < snapshot.data!.docs.length && i < 2; i++)
                            ReviewItem(review: snapshot.data!.docs[i].data() as Map<String, dynamic>),
                          // View All button if there are more than 2 reviews
                          if (snapshot.data!.docs.length > 2)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewsScreen(productId: widget.product['productId']),
                                    ),
                                  );
                                },
                                child: Text('View All', style: TextStyle(color: AppColors.textPrimaryColor)),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Estimated Completion:',
                    style: AppTextStyles.subheading,
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.product['estimatedCompletion'],
                    style: AppTextStyles.body,
                  ),
                  // ... Rest of your UI code remains the same
                  SizedBox(height: 20),
                  Row(
                    children: [
                      ElevatedButton(
                        style: AppButtonStyles.smallButton,
                        onPressed: () {
                          context.read<CartBloc>().add(AddToCartEvent(widget.product));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to cart')),
                          );
                        },
                        child: Text('Add to cart'),
                      ),
                      SizedBox(width: 30),
                      ElevatedButton(
                        style: AppButtonStyles.smallButton,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(
                                product: widget.product,
                              ),
                            ),
                          );
                        },
                        child: Text('Book Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
