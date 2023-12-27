import 'package:flutter/material.dart';

import '../themes/colors/colors.dart';

class ReTextField extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;
  final bool? enabled;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final Widget? label;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final bool? filled;
  final bool? isDense;
  final double borderRadius;
  final BorderSide borderSide;
  final Color? cursorColor;
  final bool readOnly;
  final String fontFamily;
  final int maxLine;
  final int? minLine;
  const ReTextField({
    super.key,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 4,
    ),
    this.validator,
    this.autofocus = false,
    this.enabled,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    required this.textController,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w400,
    this.textColor = ColorsTheme.primary,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.isDense = true,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
    this.borderRadius = 12,
    this.borderSide = BorderSide.none,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.fillColor = ColorsTheme.surface,
    this.filled = true,
    this.hintText,
    this.label,
    this.cursorColor = ColorsTheme.primary,
    this.readOnly = false,
    this.fontFamily = 'SourceSansPro',
    this.maxLine = 1,
    this.minLine,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        maxLines: maxLine,
        minLines: minLine,
        controller: textController,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLength: maxLength,
        enabled: enabled,
        autofocus: autofocus,
        autovalidateMode: autovalidateMode,
        readOnly: readOnly,
        cursorColor: cursorColor,
        style: TextStyle(
          fontFamily: fontFamily,
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: textColor,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          label: label,
          contentPadding: contentPadding,
          fillColor: fillColor,
          filled: filled,
          isDense: isDense,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: borderSide,
          ),
          hintStyle: TextStyle(
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: textColor.withOpacity(0.4),
          ),
        ),
        onChanged: onChanged,
        onTap: onTap,
      ),
    );
  }
}
