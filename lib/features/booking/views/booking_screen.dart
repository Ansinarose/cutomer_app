import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/booking/views/booking_address.dart';
import 'package:customer_application/features/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const BookingScreen({Key? key, required this.product}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final int currentStep = 1; // Change this to 2 when the payment step is active
  Map<String, dynamic>? selectedAddress;
  String? selectedColor;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDefaultAddress();
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
              Text(
                'Review your Bookings',
                style: AppTextStyles.subheading,
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
              SizedBox(height: 20),
              Text(
                'Estimated work completion: ${widget.product['estimatedCompletion']}',
                style: AppTextStyles.body,
              ),
              SizedBox(height: 10),
              Divider(
                color: AppColors.textPrimaryColor,
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.product['imageUrl'],
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product['title'],
                              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '₹${widget.product['price']}',
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColors.textPrimaryColor,
              ),
              _buildColorSelection(),
              SizedBox(height: 10,),
              Divider(color: AppColors.textPrimaryColor,),
              Text('Delivery Address', style: AppTextStyles.subheading),
              SizedBox(height: 10),
              if (selectedAddress != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedAddress!['name'], style: AppTextStyles.body),
                    Text(selectedAddress!['phone'], style: AppTextStyles.body),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: AppButtonStyles.smallButton,
                  onPressed: _showAddressSelection,
                  child: Text('Full Address'),
                ),
              ],
              Padding(
                padding: const EdgeInsets.only(left: 180.0),
                child: ElevatedButton(
                  style: AppButtonStyles.smallButton,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BookingAddressScreen()),
                    ).then((_) => _fetchDefaultAddress());
                  },
                  child: Text('Add a Address'),
                ),
              ),
              Divider(color: AppColors.textPrimaryColor),
              // Add more booking details or a "Proceed to Payment" button here
              if(selectedAddress != null)...[
              Row(
                children: [
                  Text(selectedAddress!['name'], style: AppTextStyles.body),
                  SizedBox(width: 50,),
                  Text(selectedAddress!['phone'], style: AppTextStyles.body),
                ],
                
              ),
              Text(selectedAddress!['houseNo'], style: AppTextStyles.body),
              Text(selectedAddress!['road'], style: AppTextStyles.body),
              Row(
                children: [
                  Text(selectedAddress!['pincode'], style: AppTextStyles.body),
                  SizedBox(width: 50,),
                  Text(selectedAddress!['city'], style: AppTextStyles.body),
                ],
              ),
              Text(selectedAddress!['state'], style: AppTextStyles.body),
              Text(selectedAddress!['landmark'], style: AppTextStyles.body),
              ],
              Divider(color: AppColors.textPrimaryColor,),
              SizedBox(height: 10,),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(padding: EdgeInsets.all(10),
                child: Column(
                  children: [Text('Total price details: Note: Price may vary based on material quality and dimensions.',style: 
                  AppTextStyles.body,),
                  Text('price: ${widget.product['price']}',style: AppTextStyles.subheading,),

                           ],   
                              
                ),),
                
              ),
              SizedBox(height: 15,),
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

  void _showAddressSelection() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final addressesSnapshot = await FirebaseFirestore.instance
          .collection('customer')
          .doc(user.uid)
          .collection('addresses')
          .get();

      if (addressesSnapshot.docs.isNotEmpty) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return ListView.builder(
              itemCount: addressesSnapshot.docs.length,
              itemBuilder: (context, index) {
                final address = addressesSnapshot.docs[index].data();
                return ListTile(
                  title: Text('${address['name']} - ${address['phone']}'),
                  subtitle: Text('${address['houseNo']}, ${address['road']}, ${address['city']}, ${address['state']} - ${address['pincode']}'),
                  onTap: () {
                    setState(() {
                      selectedAddress = address;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No addresses found. Please add an address.')),
        );
      }
    }
  }
  Widget _buildColorSelection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Available Colors:', style: AppTextStyles.subheading),
      SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: (widget.product['colors'] as List<dynamic>).map((color) => 
          ChoiceChip(
            label: Text(color),
            selected: selectedColor == color,
            onSelected: (bool selected) {
              setState(() {
                selectedColor = selected ? color : null;
              });
            },
            backgroundColor: AppColors.textsecondaryColor,
            selectedColor: AppColors.textPrimaryColor,
            labelStyle: TextStyle(
              color: selectedColor == color ? Colors.white : AppColors.textPrimaryColor
            ),
          )
        ).toList(),
      ),
    ],
  );
}
Future<void> _storeBookingData() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && selectedAddress != null && selectedColor != null) {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseFirestore.instance.collection('Customerbookings').add({
        'userId': user.uid,
        'productImage': widget.product['imageUrl'],
        'productTitle': widget.product['title'],
        'productPrice': widget.product['price'],
        'selectedColor': selectedColor,
        'productEstimatedCompletion':widget.product['estimatedCompletion'],
        'address': selectedAddress,
        'timestamp': FieldValue.serverTimestamp(),
        'orderPlacedAt': FieldValue.serverTimestamp(),
        'bookingConfirmedAt': null,
        'workStartedAt': null,
        'workCompletedAt': null,
        'paymentCompletedAt': null,
        'finishedAt': null,
      });
      
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking successful!')),
      );

      // Navigate to HomeScreen
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error storing booking data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to store booking. Please try again.')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select a color and ensure an address is set.')),
    );
  }
}
}