import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';


class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirmLogout;

  const LogoutDialog({
    Key? key,
    required this.onConfirmLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout',style: AppTextStyles.heading,),
      content: Text('Are you sure you want to logout?',style: AppTextStyles.caption,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel',style:AppTextStyles.body,),
        ),
        TextButton(
          onPressed: () {
            onConfirmLogout(); 
          },
          child: Text('Logout',style: AppTextStyles.body,),
        ),
      ],
    );
  }
}
