import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

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