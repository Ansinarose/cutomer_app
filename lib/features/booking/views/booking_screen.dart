import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  final int currentStep = 1; // Change this to 2 when the payment step is active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Title(
              color: AppColors.textPrimaryColor,
              child: Text(
                'Review your Bookings',
                style: AppTextStyles.subheading,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                // Step 1
                Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: currentStep == 1
                          ? AppColors.textPrimaryColor
                          : Colors.grey,
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Review',
                        style: TextStyle(
                          color: currentStep == 1
                              ? AppColors.textPrimaryColor
                              : Colors.grey,
                        )),
                  ],
                ),
                // Connecting Line
                Expanded(
                  child: Container(
                    height: 2,
                    color: currentStep > 1 ? AppColors.textPrimaryColor : Colors.grey,
                  ),
                ),
                // Step 2
                Column(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: currentStep == 2
                          ? AppColors.textPrimaryColor
                          : Colors.grey,
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Payment',
                        style: TextStyle(
                          color: currentStep == 2
                              ? AppColors.textPrimaryColor
                              : Colors.grey,
                        )),
                  ],
                ),
              ],
            ),
            Divider(
              color: AppColors.textPrimaryColor,
            ),
            // Add your other UI elements below the indicator
            SizedBox(height: 20),
            // Add content here...
          ],
        ),
      ),
    );
  }
}
