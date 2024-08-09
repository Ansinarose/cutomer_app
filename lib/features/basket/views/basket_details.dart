import 'package:customer_application/common/widgets/item_status.dart';
import 'package:customer_application/features/payment/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/constants/textform_field.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;
  final String productId;

  const BookingDetailsScreen({Key? key, required this.bookingId, required this.productId}) : super(key: key);

  @override
  _BookingDetailsScreenState createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        title: Text('Booking Details', style: AppTextStyles.whiteBody),
        backgroundColor: AppColors.textPrimaryColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Customerbookings')
            .doc(widget.bookingId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Booking not found'));
          }

          var bookingData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking ID: ${widget.bookingId}', style: AppTextStyles.subheading),
                SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                bookingData['productImage'] ?? '',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.error),
                                    ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(bookingData['productTitle'] ?? 'No Title', style: AppTextStyles.subheading),
                                  SizedBox(height: 8),
                                  Text('Price: ₹${bookingData['productPrice'] ?? 'N/A'}', style: AppTextStyles.body),
                                  SizedBox(height: 8),
                                  Text('Color: ${bookingData['selectedColor'] ?? 'N/A'}', style: AppTextStyles.body),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text('Estimated Work Completion: ${bookingData['productEstimatedCompletion'] ?? 'N/A'}', style: AppTextStyles.body),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Divider(color: AppColors.textPrimaryColor),
                SizedBox(height: 16),
                Text('Order Status', style: AppTextStyles.subheading),
                SizedBox(height: 16),
                _buildOrderStatus(bookingData),
                SizedBox(height: 20),
                Divider(color: AppColors.textPrimaryColor),
                SizedBox(height: 10),
                Text('Add a review about the product:', style: AppTextStyles.subheading),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Add a review about the product',
                  controller: _reviewController,
                  prefixIcon: Icons.reviews,
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    style: AppButtonStyles.smallButton,
                    onPressed: _submitReview,
                    child: Text('Add Review'),
                  ),
                ),
                Text('Pay Now:', style: AppTextStyles.subheading,),
                Center(
                  child: ElevatedButton(
                    style: AppButtonStyles.smallButton,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentsScreen(bookingId: widget.bookingId),
                      ));
                    },
                    child: Text('Pay Now')
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrderStatus(Map<String, dynamic> bookingData) {
    List<Map<String, dynamic>> statuses = [
      {'status': 'Order Placed', 'timestamp': bookingData['orderPlacedAt']},
      {'status': 'Booking Confirmed', 'timestamp': bookingData['bookingConfirmedAt']},
      {'status': 'Work Started', 'timestamp': bookingData['workStartedAt']},
      {'status': 'Work Completed', 'timestamp': bookingData['workCompletedAt']},
      {'status': 'Payment Completed', 'timestamp': bookingData['paymentCompletedAt']},
      {'status': 'Finished', 'timestamp': bookingData['finishedAt']},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: statuses.map((status) {
        return OrderStatusItem(
          status: status['status'],
          timestamp: status['timestamp']?.toDate(),
          isActive: status['timestamp'] != null,
        );
      }).toList(),
    );
  }

  Future<void> _submitReview() async {
    if (_reviewController.text.isNotEmpty) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          DocumentSnapshot userDoc = await FirebaseFirestore.instance
              .collection('customer')
              .doc(user.uid)
              .get();
          
          String reviewerName = userDoc['name'] ?? 'Anonymous'; 

          await FirebaseFirestore.instance.collection('customerreviews').add({
            'bookingId': widget.bookingId,
            'userId': user.uid,
            'productId': widget.productId,
            'review': _reviewController.text,
            'reviewerName': reviewerName,
            'timestamp': FieldValue.serverTimestamp(),
          });
          _reviewController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Review submitted successfully')),
          );
        }
      } catch (e) {
        print("Error submitting review: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit review: $e')),
        );
      }
    }
  }
}