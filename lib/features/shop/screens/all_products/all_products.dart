
import 'package:e_commerce_app/common/widgets/appbar/appbar.dart';
import 'package:e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/loaders/vertical_product_shimmer.dart';
import '../../../../common/widgets/products/sortable/sortable_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../controllers/product/get_all_product_controller.dart';
import '../../models/product_model.dart';


class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>> Function()? futureMethod;


  @override
  Widget build(BuildContext context) {
    // Initialize controller for managing product fetching
    final controller = AllProductsController.instance;

    return Scaffold(
      // AppBar
      appBar: BasicAppBar(title: Text(title), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: FutureBuilder(
            future: futureMethod?.call() ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              // Check the state of the FutureBuilder snapshot
              const loader = VerticalProductShimmer();
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loader;
              }

              if (snapshot.hasError) {
                print('--------------------Debug------------------(${snapshot.error})');
                return const Center(child: Text('Something went wrong.'));
              }
              if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(child: Text('No Data Found!'));
              }


              // Products found
              final products = snapshot.data!;

              return SortableProducts(products: products,);
            },
          ),
        ),
      ),
    );
  }
}