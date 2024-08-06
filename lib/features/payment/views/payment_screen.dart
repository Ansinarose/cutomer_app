import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/payment/views/payment_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_application/services/razorpay_service.dart';

class PaymentsScreen extends StatefulWidget {
  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final RazorpayService _razorpayService = RazorpayService();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _razorpayService.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
        title: Text('Pay to Alfa works', style: AppTextStyles.whiteBody),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount (INR)',
                labelStyle: TextStyle(color: AppColors.textPrimaryColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textPrimaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textPrimaryColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textPrimaryColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: AppButtonStyles.largeButton,
              child: Text('Pay Now'),
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  double amount = double.parse(_amountController.text);
                  _razorpayService.initiatePayment(amount);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter an amount')),
                  );
                }
              },
            ),
            SizedBox(height: 50,),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PaymentHistoryScreen()),
                );
              },
              child: Text(
                'View History',
                style: TextStyle(color: AppColors.textPrimaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
