import 'package:e_commerce_app/utils/theme/custom_themes/curved_edgets.dart';
import 'package:flutter/material.dart';
class CurvedEdgesWidget extends StatelessWidget {
  final Widget child;

  const CurvedEdgesWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdges(), child: child);
  }
}
