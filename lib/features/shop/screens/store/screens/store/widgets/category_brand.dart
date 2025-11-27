import 'package:e_commerce_app/common/widgets/brand/brand_show_case.dart';
import 'package:e_commerce_app/common/widgets/loaders/shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../../common/widgets/loaders/list_tile_shimmer.dart';
import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/helpers/cloud_helper_function.dart';

class CategoryBrands extends StatelessWidget {
  final CategoryModel category;

  const CategoryBrands({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          //  Loader, No Record, OR Error Message
          final loader = Column(
            children: [
              const ListTileShimmer(),
              SizedBox(height: AppSizes.spaceBtwItems),
            ],
          );

          final widget = CloudHelperFunctions.checkMultiRecordState(
              snapshot: snapshot, loader: loader);
          if (widget != null) return widget;
          final brands = snapshot.data!;
          return ListView.builder(itemCount: brands.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
            final brand = brands[index];
              return FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id, limit: 3),

                builder: (context, asyncSnapshot) {
                  final widget = CloudHelperFunctions.checkMultiRecordState(
                    snapshot: asyncSnapshot,
                    // Bạn có thể dùng Shimmer hoặc một loader đơn giản
                    loader: ShimmerEffect(width: 100, height: 100),
                  );
                  if (widget != null) return widget;
                  final products = asyncSnapshot.data!;
                  return BrandShowcase(brand: brand,image: products.map((e) => e.thumbnail,).toList(),);
                }
              );

            },);
        }
    );
  }
}
