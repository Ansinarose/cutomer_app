
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/widgets/bottom_nav_bar.dart';
import 'package:customer_application/features/profile/views/profile_screen.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 234, 247),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: AppBar(
          backgroundColor: AppColors.textPrimaryColor,
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                Text(
                  'Hello \nWhat do you want to purchase?',
                  style: AppTextStyles.whiteBody,
                ),
                IconButton(
                  onPressed: () {},
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
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Companyservices').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              List<DocumentSnapshot> documents = snapshot.data!.docs;

              return Row(
                children: documents.map((doc) {
                  String serviceName = doc['name'];
                  String imageUrl = doc['imageUrl'];

                  return _buildSliderItem(serviceName, imageUrl);
                }).toList(),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 0,
        onTap: (index) {
          print('Selected index: $index');
        },
      ),
    );
  }

Widget _buildSliderItem(String serviceName, String imageUrl) {
  return Container(
    width: 120,
    height: 180,
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: AppColors.scaffoldBackgroundcolor,
      borderRadius: BorderRadius.circular(15), // Rounded corners for the container
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect( // ClipRRect to apply rounded corners to the container
      borderRadius: BorderRadius.circular(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Rounded corners for the image
              border: Border.all(
                color: Colors.white, // Border color
                width: 2, // Border width
              ),
            ),
            child: ClipRRect( // ClipRRect for the image inside the border
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              serviceName,
              style: AppTextStyles.body,
            ),
          ),
        ],
      ),
    ),
  );
}
}
