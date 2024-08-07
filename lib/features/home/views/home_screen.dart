// ignore_for_file: unused_import

import 'package:customer_application/common/widgets/appbar_widgets.dart';
import 'package:customer_application/common/widgets/category_list.dart';
import 'package:customer_application/common/widgets/chat_floatingaction_button.dart';
import 'package:customer_application/common/widgets/highlights_carousel.dart';
import 'package:customer_application/common/widgets/seviceSlider.dart';
import 'package:customer_application/features/basket/views/basket_screen.dart';
import 'package:customer_application/features/payment/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/widgets/bottom_nav_bar.dart';

import 'package:customer_application/features/cart/views/cart_screen.dart';


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
 String _searchQuery = '';


  @override
  void initState() {
    super.initState();
    _highlightsFuture = _fetchHighlights();
  }


void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
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
      String id = doc.id;
      return {
        'id': id,
        'name': data['name'],
        'imageUrl': imageUrl,
      };
    }).toList();
  }

  Future<List<String>> _fetchHighlights() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('CompanyHighlights')
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => doc['imageUrl'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 234, 247),
      appBar: AppBarWidget(onSearchChanged: _onSearchChanged),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceSlider(
              selectedServiceId: selectedServiceId,
              onServiceSelected: _onServiceSelected,
            ),
            SizedBox(height: 30),
            if (selectedServiceId == null)
              HighlightsCarousel(highlightsFuture: _highlightsFuture!),
            if (_categoryFuture != null)
              CategoryList(categoryFuture: _categoryFuture!,
              searchQuery: _searchQuery,),
          ],
        ),
      ),
      floatingActionButton: ChatFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavBar(
        initialIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on home screen
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
              break;
               case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentsScreen()),
              );
              break;
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
}


