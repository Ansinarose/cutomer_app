
// import 'package:customer_application/common/widgets/slider_items.dart';
// import 'package:customer_application/common/widgets/category_list_item.dart';
// import 'package:customer_application/features/basket/basket_screen.dart';
// import 'package:customer_application/features/cart/views/cart_screen.dart';
// import 'package:customer_application/features/category/views/category_details.dart';
// import 'package:customer_application/features/notification/views/notification_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:customer_application/common/constants/app_colors.dart';
// import 'package:customer_application/common/constants/app_text_styles.dart';
// import 'package:customer_application/common/widgets/bottom_nav_bar.dart';
// import 'package:customer_application/features/profile/views/profile_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class HomeScreenWrapper extends StatelessWidget {
//   const HomeScreenWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return HomeScreen();
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? selectedServiceId;
//   Future<List<Map<String, dynamic>>>? _categoryFuture;

//   void _onServiceSelected(String serviceId) {
//     setState(() {
//       selectedServiceId = serviceId;
//       _categoryFuture = _fetchCategories(serviceId);
//     });
//   }

//   Future<List<Map<String, dynamic>>> _fetchCategories(String serviceId) async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('Companycategory')
//         .where('serviceId', isEqualTo: serviceId)
//         .get();

//     return querySnapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       List<dynamic> categoryData = data['categoryData'] ?? [];
//       String imageUrl = categoryData.isNotEmpty ? categoryData[0]['imageUrl'] ?? '' : '';
//       String id = doc.id;  // Ensure the id is included in the map
//       return {
//         'id': id,
//         'name': data['name'],
//         'imageUrl': imageUrl,
//         // Add other fields as needed
//       };
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 247, 234, 247),
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(160.0),
//         child: AppBar(
//           backgroundColor: AppColors.textPrimaryColor,
//           title: Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 StreamBuilder<DocumentSnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('customer')
//                       .doc(FirebaseAuth.instance.currentUser?.uid)
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return CircleAvatar(
//                         backgroundColor: Colors.grey,
//                         radius: 25,
//                       );
//                     }

//                     var userData = snapshot.data!.data() as Map<String, dynamic>;
//                     String name = userData['name'] ?? '';
//                     String imageUrl = userData['image_url'] ?? '';

//                     return Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(builder: (context) => ProfileScreen()),
//                             );
//                           },
//                           child: CircleAvatar(
//                             radius: 25,
//                             backgroundImage: imageUrl.isNotEmpty
//                                 ? NetworkImage(imageUrl) as ImageProvider
//                                 : AssetImage('assets/images/565-5657886_avatar-images-for-login-form-clipart.png'),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           'Hello, $name \n What do you want to purchase?',
//                           style: AppTextStyles.whiteBody,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationScreen()));
//                   },
//                   icon: Icon(Icons.notifications_active, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           flexibleSpace: Stack(
//             children: [
//               Positioned(
//                 bottom: 0,
//                 left: 26,
//                 right: 26,
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: AppColors.scaffoldBackgroundcolor,
//                     borderRadius: BorderRadius.circular(0),
//                   ),
//                   child: Row(
//                     children: [
//                       SizedBox(width: 16),
//                       Icon(Icons.search),
//                       SizedBox(width: 8),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: 'Search...',
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance.collection('Companyservices').snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return Center(child: CircularProgressIndicator());
//                     }

//                     List<DocumentSnapshot> documents = snapshot.data!.docs;

//                     return Row(
//                       children: documents.map((doc) {
//                         String serviceId = doc.id;
//                         String serviceName = doc['name'];
//                         String imageUrl = doc['imageUrl'];

//                         return GestureDetector(
//                           onTap: () => _onServiceSelected(serviceId),
//                           child: SliderItem(
//                             serviceName: serviceName,
//                             imageUrl: imageUrl,
//                             isSelected: selectedServiceId == serviceId,
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             if (_categoryFuture != null)
//               FutureBuilder<List<Map<String, dynamic>>>(
//                 future: _categoryFuture,
//                 builder: (context, categorySnapshot) {
//                   if (!categorySnapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }

//                   var categories = categorySnapshot.data!;
//                   if (categories.isEmpty) {
//                     return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Text('No categories available.'),
//                     );
//                   }

//                   return Padding(
//                     padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: categories.map((categorySet) {
//                         String categoryId = categorySet['id'] ?? '';
//                         if (categoryId.isEmpty) {
//                           print('Category ID is empty or null for category: ${categorySet['name']}');
//                         }

//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 8.0),
//                           child: CategoryListItem(
//                             name: categorySet['name'],
//                             imageUrl: categorySet['imageUrl'] ?? '',
//                             onTap: () {
//                               if (categoryId.isNotEmpty) {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CategoryDetailsScreen(categoryId: categoryId),
//                                   ),
//                                 );
//                               } else {
//                                 print('Category ID is missing, cannot navigate.');
//                               }
//                             },
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavBar(
//         initialIndex: 0,
//         onTap: (index) {
//           switch (index) {
//             case 0:
              
//               break;
//             case 1:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CartScreen()),
//               );
//               break;
//             // case 2:
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(builder: (context) => PaymentsScreen()),
//             //   );
//             //   break;
//             case 3:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => BasketScreen()),
//               );
//               break;
//             default:
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
// //                 context,
// //                 MaterialPageRoute(builder: (context) => BasketScreen()),
// //               );
// //               break;
// //             default:
// //               break;
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_application/common/widgets/slider_items.dart';
import 'package:customer_application/common/widgets/category_list_item.dart';
import 'package:customer_application/features/basket/basket_screen.dart';
import 'package:customer_application/features/cart/views/cart_screen.dart';
import 'package:customer_application/features/category/views/category_details.dart';
import 'package:customer_application/features/notification/views/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/widgets/bottom_nav_bar.dart';
import 'package:customer_application/features/profile/views/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedServiceId;
  Future<List<Map<String, dynamic>>>? _categoryFuture;
  Future<List<String>>? _highlightsFuture;

   @override
  void initState() {
    super.initState();
    _highlightsFuture = _fetchHighlights();
  }

  void _onServiceSelected(String serviceId) {
    setState(() {
      selectedServiceId = serviceId;
      _categoryFuture = _fetchCategories(serviceId);
       _highlightsFuture = null;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchCategories(String serviceId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Companycategory')
        .where('serviceId', isEqualTo: serviceId)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> categoryData = data['categoryData'] ?? [];
      String imageUrl = categoryData.isNotEmpty ? categoryData[0]['imageUrl'] ?? '' : '';
      String id = doc.id;  // Ensure the id is included in the map
      return {
        'id': id,
        'name': data['name'],
        'imageUrl': imageUrl,
        // Add other fields as needed
      };
    }).toList();
  }

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
                StreamBuilder<DocumentSnapshot>(
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

                    var userData = snapshot.data!.data() as Map<String, dynamic>;
                    String name = userData['name'] ?? '';
                    String imageUrl = userData['image_url'] ?? '';

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
                                : AssetImage('assets/images/565-5657886_avatar-images-for-login-form-clipart.png'),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Hello, $name \n What do you want to purchase?',
                          style: AppTextStyles.whiteBody,
                        ),
                      ],
                    );
                  },
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
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
                          onTap: () => _onServiceSelected(serviceId),
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
            ),

            SizedBox(height: 30,),

             if (selectedServiceId == null)
             _buildHighlightsCarousel(),
            
            if (_categoryFuture != null)
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _categoryFuture,
                builder: (context, categorySnapshot) {
                  if (!categorySnapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var categories = categorySnapshot.data!;
                  if (categories.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('No categories available.'),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categories.map((categorySet) {
                        String categoryId = categorySet['id'] ?? '';
                        if (categoryId.isEmpty) {
                          print('Category ID is empty or null for category: ${categorySet['name']}');
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: CategoryListItem(
                            name: categorySet['name'],
                            imageUrl: categorySet['imageUrl'] ?? '',
                            onTap: () {
                              if (categoryId.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryDetailsScreen(categoryId: categoryId),
                                  ),
                                );
                              } else {
                                print('Category ID is missing, cannot navigate.');
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
              break;
            // case 2:
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => PaymentsScreen()),
            //   );
            //   break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BasketScreen()),
              );
              break;
            default:
              break;
          }
        },
      ),
    );
  }
  Future<List<String>> _fetchHighlights() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('CompanyHighlights')
      .orderBy('timestamp', descending: true)
      .get();

  return querySnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
}
 Widget _buildHighlightsCarousel() {
    return FutureBuilder<List<String>>(
      future: _highlightsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Text(
                  'Highlights',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: snapshot.data!.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                            children: [
                              Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 20.0,
                                  ),
                                  child: Text(
                                    'ALFA HighlightS',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
