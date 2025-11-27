import 'package:e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:e_commerce_app/features/shop/screens/home/widgets/category_shimmer.dart';
import 'package:e_commerce_app/features/shop/screens/sub_category/sub_categories.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/texts/vertical_item.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final dark = HelperFunctions.isDarkMode(context);
    return Obx((){
      if(categoryController.isLoading.value) return const CategoryShimmer();
      if(categoryController.featuredCategories.isEmpty){
        return Center(child: Text('No Data Found', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),),);
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return VerticalItem(
              dark: dark,
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => SubCategoriesScreen(category: category,)),);
          },
        ),
      );
    });
  }
}
