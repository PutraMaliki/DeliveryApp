import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Custom SVG Loader
class ReSVGLoader extends StatelessWidget {
  final String path;
  final String semanticsLabel;
  final EdgeInsetsGeometry margin;
  final double width;
  final double height;
  final ColorFilter? colorFilter;

  const ReSVGLoader({
    super.key,
    required this.path,
    this.semanticsLabel = "",
    this.margin = const EdgeInsets.all(0),
    this.width = 24,
    this.height = 24,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: SvgPicture.asset(
          path,
          semanticsLabel: semanticsLabel,
          colorFilter: colorFilter,
        ),
      ),
    );
  }
}
