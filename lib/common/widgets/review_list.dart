// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:customer_application/common/constants/app_text_styles.dart';
// import 'package:flutter/material.dart';

// class ReviewItem extends StatelessWidget {
//   final Map<String, dynamic> review;

//   const ReviewItem({Key? key, required this.review}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print('Review Data: $review'); // For debugging

//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               review['review'] ?? 'No review text available',
//               style: AppTextStyles.body,
//             ),
//             SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end, // Aligns the Row to the right
//               children: [
//                 Text(
//                   'Reviewed by: ${review['userName'] ?? 'Anonymous'}',
//                   style: AppTextStyles.caption,
//                 ),
//                 SizedBox(width: 10), // Space between the two texts
//                 Text(
//                   'Posted on: ${_formatDate(review['timestamp'])}',
//                   style: AppTextStyles.caption,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(Timestamp timestamp) {
//     DateTime date = timestamp.toDate();
//     return '${date.day}/${date.month}/${date.year}';
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewItem({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Review Data: $review'); // For debugging

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review['review'] ?? 'No review text available',
              style: AppTextStyles.body,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end, // Aligns the Row to the right
              children: [
                Text(
                  'Reviewed by: ${review['reviewerName'] ?? 'Anonymous'}',
                  style: AppTextStyles.caption,
                ),
                SizedBox(width: 10), // Space between the two texts
                Text(
                  'Posted on: ${_formatDate(review['timestamp'])}',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year}';
  }
}
