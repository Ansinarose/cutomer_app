import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ColorSelection extends StatelessWidget {
  final List<dynamic> colors;
  final String? selectedColor;
  final Function(String) onColorSelected;

  const ColorSelection({Key? key, required this.colors, this.selectedColor, required this.onColorSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Available Colors:', style: AppTextStyles.subheading),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: colors.map((color) => 
            ChoiceChip(
              label: Text(color),
              selected: selectedColor == color,
              onSelected: (bool selected) => onColorSelected(selected ? color : ''),
              backgroundColor: AppColors.textsecondaryColor,
              selectedColor: AppColors.textPrimaryColor,
              labelStyle: TextStyle(color: selectedColor == color ? Colors.white : AppColors.textPrimaryColor),
            )
          ).toList(),
        ),
      ],
    );
  }
}