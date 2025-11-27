import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/common/widgets/loaders/vertical_product_shimmer.dart';
import 'package:e_commerce_app/features/shop/controllers/product/get_all_product_controller.dart';
import 'package:e_commerce_app/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce_app/features/shop/models/brand_model.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/brand/brand_card.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';

class BrandProducts extends StatelessWidget {
  final BrandModel brand;
  const BrandProducts({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar:  BasicAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Brand Detail
              BrandCard(showBorder: true, onTap: () {}, brand:brand,),
              const SizedBox(height: AppSizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProducts( brandId: brand.id),
                builder: (context, asyncSnapshot) {
                  print('Fetching products for brandId: ${brand.id}');

                  const loader = VerticalProductShimmer();
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return loader;
                  }

                  if (asyncSnapshot.hasError) {
                    print('--------------------Debug------------------(${asyncSnapshot.error})');
                    return const Center(child: Text('Something went wrong.'));
                  }
                  if (!asyncSnapshot.hasData || asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No Data Found!'));
                  }
                  return SortableProducts(products:asyncSnapshot.data!,);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}