import 'package:customer_application/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PriceRange {
  final String label;
  final double min;
  final double max;

  PriceRange(this.label, this.min, this.max);
}

class PriceFilterWidget extends StatelessWidget {
  final List<PriceRange> priceRanges;
  final PriceRange? selectedPriceRange;
  final Function(PriceRange?) onPriceRangeSelected;

  PriceFilterWidget({
    Key? key,
    required this.priceRanges,
    required this.selectedPriceRange,
    required this.onPriceRangeSelected,
  }) : super(key: key);

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter by Price Range', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Container(
            width: double.maxFinite,
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: priceRanges.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onPriceRangeSelected(priceRanges[index]);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedPriceRange == priceRanges[index]
                          ? Color.fromARGB(255, 7, 7, 7).withOpacity(0.2)
                          : Color.fromARGB(255, 54, 47, 47).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selectedPriceRange == priceRanges[index]
                            ? Color.fromARGB(255, 15, 15, 15)
                            : Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        priceRanges[index].label,
                        style: TextStyle(
                          fontWeight: selectedPriceRange == priceRanges[index]
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedPriceRange == priceRanges[index]
                              ? Colors.blue
                              : Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Clear Filter', style: TextStyle(color: AppColors.textPrimaryColor)),
              onPressed: () {
                onPriceRangeSelected(null);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Close', style: TextStyle(color: AppColors.textPrimaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (selectedPriceRange != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              selectedPriceRange!.label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        IconButton(
          onPressed: () => _showFilterDialog(context),
          icon: Icon(
            Icons.filter_list,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}