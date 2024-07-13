// import 'package:flutter/material.dart';
// import 'package:customer_application/common/constants/app_colors.dart';
// import 'package:customer_application/common/constants/app_text_styles.dart';

// class CategoryListItem extends StatelessWidget {
//   final String name;
//   final String imageUrl;
//    final VoidCallback onTap;
//   const CategoryListItem({
//     Key? key,
//     required this.name,
//     required this.imageUrl,
//      required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 130,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.0),
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Center(
//                   child: Text(
//                     name,
//                     style: AppTextStyles.body,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               Icon(Icons.arrow_forward_ios_outlined, color: AppColors.textPrimaryColor),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';

class CategoryListItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryListItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onTap, // Trigger onTap callback when card is tapped
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Center(
                    child: Text(
                      name,
                      style: AppTextStyles.body,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined, color: AppColors.textPrimaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
