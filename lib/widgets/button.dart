import 'package:flutter/material.dart';

import 'package:skripsi_kos_app/themes/colors/colors.dart';

class ReElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final void Function()? onPressed;
  final Color backgroundColor;
  final Color shadowColor;
  final Color disableBackgroundColor;
  final Widget? child;
  final double borderRadius;
  final double elevation;
  final BorderSide side;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry circlePadding;
  final bool isCircle;
  const ReElevatedButton({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    required this.onPressed,
    required this.child,
    this.backgroundColor = ColorsTheme.button,
    this.shadowColor = Colors.transparent,
    this.disableBackgroundColor = ColorsTheme.disabled,
    this.borderRadius = 24,
    this.elevation = 1.5,
    this.side = BorderSide.none,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 4,
    ),
    this.circlePadding = const EdgeInsets.fromLTRB(16, 16, 16, 16),
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: shadowColor,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: disableBackgroundColor,
          elevation: elevation,
          shape: isCircle
              ? CircleBorder(
                  side: side,
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  side: side,
                ),
        ),
        child: Padding(
          padding: isCircle ? circlePadding : padding,
          child: child,
        ),
      ),
    );
  }
}
