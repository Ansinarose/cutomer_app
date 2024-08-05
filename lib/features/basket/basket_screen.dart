import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/basket/basket_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Stack(
          children: [
            AppBar(
              backgroundColor: AppColors.textPrimaryColor
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: 
            // StreamBuilder<QuerySnapshot>(
            //   stream: FirebaseFirestore.instance.collection('Customerbookings').snapshots(),
            //   builder: (context, snapshot) {
            StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('Customerbookings')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .snapshots(),
  builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No bookings found'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var booking = snapshot.data!.docs[index];
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () {
  var bookingData = booking.data() as Map<String, dynamic>;
  String bookingId = booking.id;
  String productId = bookingData['productId'] ?? '';
  
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingDetailsScreen(
        bookingId: bookingId,
        productId: productId,
      ),
    ),
  );
},
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      booking['productImage'] ?? '',
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 80,
                                          height: 80,
                                          color: Colors.grey[300],
                                          child: Icon(Icons.error),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          booking['productTitle'] ?? 'No Title',
                                          style: AppTextStyles.subheading,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Price: ₹${booking['productPrice'] ?? 'N/A'}',
                                          style: AppTextStyles.body.copyWith(
                                            color: AppColors.textPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Color: ${booking['selectedColor'] ?? 'N/A'}',
                                          style: AppTextStyles.body,
                                        ),
                                         SizedBox(height: 4),
                                        Text(
                                          'Estimated work completion: ${booking['productEstimatedCompletion'] ?? 'N/A'}',
                                          style: AppTextStyles.body,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, color: AppColors.textPrimaryColor),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Text(
                              //   'How was the product experience?',
                              //   style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                              // ),
                              // SizedBox(height: 8),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: List.generate(5, (index) {
                              //     return Icon(
                              //       Icons.star_border,
                              //       color: Colors.amber,
                              //       size: 24,
                              //     );
                              //   }),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            right: 20,
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'MY ORDERS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}