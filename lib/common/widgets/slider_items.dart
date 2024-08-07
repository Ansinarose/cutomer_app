
// import 'package:flutter/material.dart';
// import 'package:customer_application/common/constants/app_colors.dart';
// import 'package:customer_application/common/constants/app_text_styles.dart';

// class SliderItem extends StatelessWidget {
//   final String serviceName;
//   final String imageUrl;
//   final bool isSelected;

//   const SliderItem({
//     Key? key,
//     required this.serviceName,
//     required this.imageUrl,
//     this.isSelected = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120,
//       height: 180,
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: isSelected
//             ? AppColors.textPrimaryColor.withOpacity(0.1)
//             : AppColors.scaffoldBackgroundcolor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//         border: Border.all(
//           color: isSelected ? AppColors.textPrimaryColor : Colors.transparent,
//           width: 2,
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: isSelected ? AppColors.textPrimaryColor : Colors.white,
//                     width: 2,
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(13),
//                   child: Image.network(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 serviceName,
//                 style: isSelected
//                     ? AppTextStyles.body.copyWith(
//                         color: AppColors.textPrimaryColor,
//                         fontWeight: FontWeight.bold,
//                       )
//                     : AppTextStyles.body,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';

class SliderItem extends StatelessWidget {
  final String serviceName;
  final String imageUrl;
  final bool isSelected;

  const SliderItem({
    Key? key,
    required this.serviceName,
    required this.imageUrl,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.textPrimaryColor.withOpacity(0.1)
            : AppColors.scaffoldBackgroundcolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: isSelected ? AppColors.textPrimaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? AppColors.textPrimaryColor : Colors.white,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Image.asset('assets/images/placeholderimage.jpeg', fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                serviceName,
                style: isSelected
                    ? AppTextStyles.body.copyWith(
                        color: AppColors.textPrimaryColor,
                        fontWeight: FontWeight.bold,
                      )
                    : AppTextStyles.body,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
