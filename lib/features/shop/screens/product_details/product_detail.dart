import 'package:e_commerce_app/features/shop/models/product_model.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_image_slider.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/product_metadata.dart';
import 'package:e_commerce_app/features/shop/screens/product_details/widgets/rating_and_share.dart';
import 'package:e_commerce_app/utils/constants/enums.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/headings/section_headings.dart';

class ProductDetail extends StatelessWidget {
  final ProductModel product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(product: product,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image slider
            ProductImageSlider(
              product: product,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: AppSizes.defaultSpace,
                  left: AppSizes.defaultSpace,
                  bottom: AppSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product rating
                  RatingAndShare(),
                  // Product price title stock brand
                  ProductMetaData(
                    product: product,
                  ),
                  // Product attribute

                  if (product.productType == ProductType.variable.toString())
                    ProductAttributes(product: product,),
                  if (product.productType == ProductType.variable.toString())
                    const SizedBox(
                      height: AppSizes.spaceBtwSections,
                    ),

                  const SectionHeading(
                    title: "Description",
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    textAlign: TextAlign.start,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "Less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: AppSizes.spaceBtwSections,
                  ),
                  const SectionHeading(
                    title: "Reviews(199)",
                    showActionButton: true,
                    buttonTitle: "View all",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
