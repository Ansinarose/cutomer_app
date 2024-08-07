import 'package:customer_application/common/widgets/filter_widget.dart';
import 'package:customer_application/common/widgets/productItem_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/common/constants/app_colors.dart';


class CategoryDetailsScreen extends StatefulWidget {
  final String categoryId;

  const CategoryDetailsScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final List<PriceRange> priceRanges = [
    PriceRange('Below 100', 0, 99),
    PriceRange('100-300', 100, 300),
    PriceRange('300-500', 300, 500),
    PriceRange('500-700', 500, 700),
    PriceRange('700-1000', 700, 1000),
    PriceRange('1000-1300', 1000, 1300),
    PriceRange('1300-1600', 1300, 1600),
    PriceRange('1600-2500', 1600, 2500),
    PriceRange('Above 2500', 2500, double.infinity),
  ];

  PriceRange? selectedPriceRange;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Companycategory')
              .doc(widget.categoryId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...', style: TextStyle(color: Colors.white, fontSize: 20));
            }
            if (!snapshot.hasData) {
              return Text('Category', style: TextStyle(color: Colors.white, fontSize: 20));
            }
            Map<String, dynamic> categoryData = snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              categoryData['name'] ?? 'Category',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            );
          },
        ),
        actions: [
          PriceFilterWidget(
            priceRanges: priceRanges,
            selectedPriceRange: selectedPriceRange,
            onPriceRangeSelected: _onPriceRangeSelected,
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Companycategory')
            .doc(widget.categoryId)
            .get(),
        builder: (context, categorySnapshot) {
          if (categorySnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!categorySnapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          Map<String, dynamic> categoryData = categorySnapshot.data!.data() as Map<String, dynamic>;
          List<dynamic> categoryProducts = categoryData['categoryData'] ?? [];

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Companycategory')
                .doc(widget.categoryId)
                .collection('items')
                .snapshots(),
            builder: (context, itemsSnapshot) {
              if (itemsSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              List<dynamic> itemProducts = [];
              if (itemsSnapshot.hasData) {
                itemsSnapshot.data!.docs.forEach((doc) {
                  Map<String, dynamic> item = doc.data() as Map<String, dynamic>;
                  itemProducts.addAll(item['itemData'] ?? []);
                });
              }

              List<dynamic> allProducts = [...categoryProducts, ...itemProducts];

              if (selectedPriceRange != null) {
                allProducts = allProducts.where((product) {
                  double price = double.tryParse(product['price'].toString()) ?? 0;
                  return price >= selectedPriceRange!.min && price <= selectedPriceRange!.max;
                }).toList();
              }

              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: allProducts.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(product: allProducts[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
  void _onPriceRangeSelected(PriceRange? range) {
    setState(() {
      selectedPriceRange = range;
    });
  }
}