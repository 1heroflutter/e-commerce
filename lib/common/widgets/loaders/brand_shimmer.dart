import 'package:e_commerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:e_commerce_app/common/widgets/loaders/shimmer.dart';
import 'package:flutter/material.dart';

class BrandsShimmer extends StatelessWidget {
  const BrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const ShimmerEffect(width: 300, height: 80),
    );
  }
}