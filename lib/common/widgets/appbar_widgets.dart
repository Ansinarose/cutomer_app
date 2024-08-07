import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/profile/views/profile_screen.dart';
import 'package:customer_application/features/notification/views/notification_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onSearchChanged;
   AppBarWidget({Key? key, required this.onSearchChanged}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(160.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.textPrimaryColor,
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('customer')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 25,
                    );
                  }

                  var userData = snapshot.data!.data() as Map<String, dynamic>?;
                  String name = userData?['name'] ?? 'Guest';
                  String imageUrl = userData?['image_url'] ?? '';

                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl) as ImageProvider
                              : AssetImage('assets/images/default_avatar.png'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Hello, $name\nWhat do you want to purchase?',
                          style: AppTextStyles.whiteBody,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
              },
              icon: Icon(Icons.notifications_active, color: Colors.white),
            ),
          ],
        ),
      ),
      flexibleSpace: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 26,
            right: 26,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.scaffoldBackgroundcolor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                      onChanged: onSearchChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    
    );
  }
}
