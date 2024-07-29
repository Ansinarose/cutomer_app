// ignore_for_file: unused_import

import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/category/views/product_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryId;

  const CategoryDetailsScreen({Key? key, required this.categoryId})
      : super(key: key);

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
                  .doc(categoryId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...',
                      style: TextStyle(color: Colors.white, fontSize: 20));
                }
                if (!snapshot.hasData) {
                  return Text('Category',
                      style: TextStyle(color: Colors.white, fontSize: 20));
                }
                Map<String, dynamic> categoryData =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Text(
                  categoryData['name'] ?? 'Category',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Companycategory')
                .doc(categoryId)
                .get(),
            builder: (context, categorySnapshot) {
              if (categorySnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!categorySnapshot.hasData) {
                return Center(child: Text('No data available'));
              }

              Map<String, dynamic> categoryData =
                  categorySnapshot.data!.data() as Map<String, dynamic>;
              List<dynamic> categoryProducts =
                  categoryData['categoryData'] ?? [];

              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Companycategory')
                    .doc(categoryId)
                    .collection('items')
                    .snapshots(),
                builder: (context, itemsSnapshot) {
                  if (itemsSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<dynamic> itemProducts = [];
                  if (itemsSnapshot.hasData) {
                    itemsSnapshot.data!.docs.forEach((doc) {
                      Map<String, dynamic> item =
                          doc.data() as Map<String, dynamic>;
                      itemProducts.addAll(item['itemData'] ?? []);
                    });
                  }

                  List<dynamic> allProducts = [
                    ...categoryProducts,
                    ...itemProducts
                  ];

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
                      Map<String, dynamic> product = allProducts[index];
                     

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                product: {
                                  ...product,
                                  'id': product['id'] ?? 'unknown_product_id',
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(8)),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: product['imageUrl'] != null
                                            ? NetworkImage(product['imageUrl'])
                                            : AssetImage(
                                                    'assets/images/default_image.png')
                                                as ImageProvider,
                                      ),
                                    ),
                                  ),
                                 
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['title'] ?? 'Unnamed Product',
                                        style: AppTextStyles.body,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '\₹${product['price'] ?? 'N/A'}',
                                        style: TextStyle(
                                            color: AppColors.textPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      SizedBox(height: 4),
                                      Expanded(
                                        child: Text(
                                          product['description'] ??
                                              'No description available',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      }

  }

