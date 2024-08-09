import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class PriceDetails extends StatelessWidget {
  final String price;

  const PriceDetails({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Total price details: Note: Price may vary based on material quality and dimensions.', style: AppTextStyles.body),
            Text('price: $price', style: AppTextStyles.subheading),
          ],
        ),
      ),
    );
  }
}