import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/features/chat/views/chat_screen.dart';

class ChatFloatingActionButton extends StatefulWidget {
  @override
  _ChatFloatingActionButtonState createState() => _ChatFloatingActionButtonState();
}

class _ChatFloatingActionButtonState extends State<ChatFloatingActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 10).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: Container(
            width: 60,
            height: 60,
            child: FloatingActionButton(
              onPressed: () {
                _showChatWarningDialog(context);
              },
              child: Text('Enqiry', style: TextStyle(fontSize: 10, color: Colors.white)),
              backgroundColor: AppColors.textPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showChatWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Chat Warning",style: AppTextStyles.subheading,),
          content: Text(
            "Please do not exploit this opportunity by sending unwanted messages. "
            "The company will respond to each query within 2 hours during business hours.",
            style: AppTextStyles.body,
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",
              style: AppTextStyles.body,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm",
              style: AppTextStyles.body,),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToChatScreen(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToChatScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerChatScreen()),
    );
  }
}