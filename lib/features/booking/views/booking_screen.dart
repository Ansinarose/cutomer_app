import 'package:customer_application/common/widgets/address_selection.dart';
import 'package:customer_application/common/widgets/booking_steps.dart';
import 'package:customer_application/common/widgets/color_selection.dart';
import 'package:customer_application/common/widgets/price_details.dart';
import 'package:customer_application/common/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/booking/views/booking_address.dart';
import 'package:customer_application/features/home/views/home_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const BookingScreen({Key? key, required this.product}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final int currentStep = 1;
  Map<String, dynamic>? selectedAddress;
  String? selectedColor;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('Product data in BookingScreen: ${widget.product}');
    _fetchDefaultAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
        title: Text('Book Now'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Review your Bookings', style: AppTextStyles.subheading),
              SizedBox(height: 20),
              BookingSteps(currentStep: currentStep),
              SizedBox(height: 20),
              Text('Estimated work completion: ${widget.product['estimatedCompletion']}', style: AppTextStyles.body),
              SizedBox(height: 10),
              Divider(color: AppColors.textPrimaryColor),
              SizedBox(height: 10),
              ProductCard(product: widget.product),
              Divider(color: AppColors.textPrimaryColor),
              ColorSelection(
                colors: widget.product['colors'],
                selectedColor: selectedColor,
                onColorSelected: (color) => setState(() => selectedColor = color),
              ),
              SizedBox(height: 10),
              Divider(color: AppColors.textPrimaryColor),
              AddressSection(
                selectedAddress: selectedAddress,
                onAddressSelected: (address) => setState(() => selectedAddress = address),
                onAddAddress: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingAddressScreen()),
                ).then((_) => _fetchDefaultAddress()),
              ),
              Divider(color: AppColors.textPrimaryColor),
              SizedBox(height: 10),
              PriceDetails(price: widget.product['price']),
              SizedBox(height: 15),
              Center(
                child: _isLoading 
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: AppButtonStyles.largeButton,
                      onPressed: _storeBookingData,
                      child: Text('Book Now')
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchDefaultAddress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final addressSnapshot = await FirebaseFirestore.instance
          .collection('customer')
          .doc(user.uid)
          .collection('addresses')
          .limit(1)
          .get();

      if (addressSnapshot.docs.isNotEmpty) {
        setState(() {
          selectedAddress = addressSnapshot.docs.first.data();
        });
      }
    }
  }

  Future<void> _storeBookingData() async {
    print('Product data: ${widget.product}');
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && selectedAddress != null && selectedColor != null) {
      setState(() => _isLoading = true);
      try {
        String productId = widget.product['productId'] ?? 'unknown_product_id';
        print('Product ID: $productId');

        await FirebaseFirestore.instance.collection('Customerbookings').add({
          'userId': user.uid,
          'productImage': widget.product['imageUrl'],
          'productTitle': widget.product['title'],
          'productPrice': widget.product['price'],
          'selectedColor': selectedColor,
          'productEstimatedCompletion': widget.product['estimatedCompletion'],
          'address': selectedAddress,
          'timestamp': FieldValue.serverTimestamp(),
          'orderPlacedAt': FieldValue.serverTimestamp(),
          'bookingConfirmedAt': null,
          'workStartedAt': null,
          'workCompletedAt': null,
          'paymentCompletedAt': null,
          'finishedAt': null,
          'productId': productId,
        });
        
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: AppColors.textPrimaryColor,
            content: Text('Booking successful!',style: AppTextStyles.whiteBody,)));
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        setState(() => _isLoading = false);
        print('Error storing booking data: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to store booking. Please try again.')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a color and ensure an address is set.')));
    }
  }
}