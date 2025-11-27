import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  final String currencySign, price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  const ProductPriceText(
      {super.key,
      this.currencySign = '\$',
      required this.price,
       this.maxLines=1,
      this.isLarge = false,
      this.lineThrough = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(currencySign + price,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: isLarge
            ? theme.textTheme.headlineMedium!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null)
            : theme.textTheme.titleLarge!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null));
  }
}
