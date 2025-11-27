import 'package:flutter/material.dart';

class ProductTitleText extends StatelessWidget {
  final String title;
  final TextAlign? textAlign;
  final int? maxLine;
  final bool smallSize;

  const ProductTitleText({
    super.key,
    required this.title,
    this.textAlign = TextAlign.left,
    this.maxLine = 2,
    this.smallSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: smallSize
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLine,
          textAlign: textAlign,
        )
      ],
    );
  }
}
