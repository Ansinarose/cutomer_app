import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressSection extends StatelessWidget {
  final Map<String, dynamic>? selectedAddress;
  final Function(Map<String, dynamic>) onAddressSelected;
  final VoidCallback onAddAddress;

  const AddressSection({Key? key, this.selectedAddress, required this.onAddressSelected, required this.onAddAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            onPressed: () => _showAddressSelection(context),
            child: Text('Full Address'),
          ),
        ],
        Padding(
          padding: const EdgeInsets.only(left: 180.0),
          child: ElevatedButton(
            style: AppButtonStyles.smallButton,
            onPressed: onAddAddress,
            child: Text('Add an Address'),
          ),
        ),
      ],
    );
  }

  void _showAddressSelection(BuildContext context) async {
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
                    onAddressSelected(address);
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
}
