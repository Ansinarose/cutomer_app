import 'package:flutter/material.dart';
import 'package:customer_application/common/widgets/category_list_item.dart';
import 'package:customer_application/features/category/views/category_details.dart';

class CategoryList extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> categoryFuture;
  final String searchQuery;

  const CategoryList({
    Key? key,
    required this.categoryFuture,
    required this.searchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: categoryFuture,
      builder: (context, categorySnapshot) {
        if (!categorySnapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var categories = categorySnapshot.data!;
        var filteredCategories = categories.where((category) =>
            category['name'].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();

        if (filteredCategories.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('No matching categories found.'),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: filteredCategories.map((categorySet) {
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
    );
  }
}