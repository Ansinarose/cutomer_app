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
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            print('No data found for booking ID: $bookingId');
            return Center(child: Text('Booking not found. ID: $bookingId'));
          }
          
          var bookingData = snapshot.data!.data() as Map<String, dynamic>;
          print('Booking data: $bookingData'); // Log the data for debugging

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Booking ID: $bookingId', style: AppTextStyles.body),
                SizedBox(height: 16),
                Text('Product: ${bookingData['productTitle'] ?? 'N/A'}', style: AppTextStyles.subheading),
                SizedBox(height: 8),
                Text('Price: ₹${bookingData['productPrice'] ?? 'N/A'}', style: AppTextStyles.body),
                SizedBox(height: 8),
                Text('Status: ${bookingData['status'] ?? 'Pending'}', style: AppTextStyles.body),
                SizedBox(height: 16),
                Text('Booking Progress:', style: AppTextStyles.subheading),
                // Here you can add more detailed progress information
                SizedBox(height: 16),
                Text('Raw Data (for debugging):', style: AppTextStyles.body),
                Text(bookingData.toString(), style: AppTextStyles.body),
              ],
            ),
          );
        },
      ),
    );
  }
}