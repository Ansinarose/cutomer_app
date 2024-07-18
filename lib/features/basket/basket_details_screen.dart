
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsScreen extends StatelessWidget {
  final String bookingId;

  const BookingDetailsScreen({Key? key, required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        title: Text('Booking Details'),
        backgroundColor: AppColors.textPrimaryColor,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('Customerbookings').doc(bookingId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
                Text('Booking ID: $bookingId', style: AppTextStyles.subheading),
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
}

class OrderStatusItem extends StatelessWidget {
  final String status;
  final DateTime? timestamp;
  final bool isActive;

  const OrderStatusItem({
    Key? key, 
    required this.status, 
    this.timestamp, 
    required this.isActive
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? AppColors.textPrimaryColor : Colors.grey,
              ),
            ),
            if (status != 'Finished')
              Container(
                width: 2,
                height: 40,
                color: isActive ? AppColors.textPrimaryColor : Colors.grey,
              ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(status, style: isActive ? AppTextStyles.subheading : AppTextStyles.body),
            if (timestamp != null)
              Text(
                '${timestamp!.day}/${timestamp!.month}/${timestamp!.year} ${timestamp!.hour}:${timestamp!.minute}',
                style: AppTextStyles.caption,
              ),
          ],
        ),
      ],
    );
  }
}



