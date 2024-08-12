import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/widgets/slider_items.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceSlider extends StatelessWidget {
  final String? selectedServiceId;
  final Function(String) onServiceSelected;

  const ServiceSlider({
    Key? key,
    required this.selectedServiceId,
    required this.onServiceSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Companyservices').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            List<DocumentSnapshot> documents = snapshot.data!.docs;

            return Row(
              children: documents.map((doc) {
                String serviceId = doc.id;
                String serviceName = doc['name'];
                String imageUrl = doc['imageUrl'];

                return GestureDetector(
                  onTap: () => onServiceSelected(serviceId),
                  child: SliderItem(
                    serviceName: serviceName,
                    imageUrl: imageUrl,
                    isSelected: selectedServiceId == serviceId,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
