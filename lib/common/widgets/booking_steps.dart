import 'package:customer_application/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BookingSteps extends StatelessWidget {
  final int currentStep;

  const BookingSteps({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep(1, 'Review'),
        Expanded(child: Container(height: 2, color: currentStep > 1 ? AppColors.textPrimaryColor : Colors.grey)),
        _buildStep(2, 'Payment'),
      ],
    );
  }

  Widget _buildStep(int step, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: currentStep == step ? AppColors.textPrimaryColor : Colors.grey,
          child: Text('$step', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: currentStep == step ? AppColors.textPrimaryColor : Colors.grey)),
      ],
    );
  }
}
