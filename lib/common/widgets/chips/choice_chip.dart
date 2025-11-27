import 'package:e_commerce_app/common/widgets/custom_shapes/containers/custom_container.dart';
import 'package:e_commerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class BasicChoiceChip extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function(bool)? onSelected;

  const BasicChoiceChip(
      {super.key,
      required this.label,
      required this.selected,
      this.onSelected});

  @override
  Widget build(BuildContext context) {
    final isColor = HelperFunctions.getColor(label) != null;
    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(label),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? AppColors.white : null),
      avatar: isColor?CircularContainer(
        width: 50,
        height: 50,
        backgroundColor: HelperFunctions.getColor(label)!,
      ):null,
      shape: isColor ? const CircleBorder() : null,
      labelPadding: isColor ?const EdgeInsets.all(0) : null,
      padding: isColor ?const EdgeInsets.all(0) : null,
      backgroundColor: isColor ? HelperFunctions.getColor(label) : null,
    );
  }
}
