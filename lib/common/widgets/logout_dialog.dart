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
      title: Text('Logout'),
      content: Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirmLogout(); // Call the callback function for logout
            // Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
