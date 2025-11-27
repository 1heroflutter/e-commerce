import 'package:e_commerce_app/common/widgets/images/circular_image.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class VerticalItem extends StatelessWidget {
  const VerticalItem({
    super.key,
    required this.onTap,
    this.backgroundColor ,
    required this.dark,
    required this.image,
    required this.title,
    this.textColor = AppColors.white,
  });

  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool dark;
  final String image;
  final String title;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Padding(
        padding: EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            // Circular Icon
          CircularImage(
            padding: 0,
            width: 50,
            height: 50,
          isNetworkImage: true, image:image,
         ),

            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
