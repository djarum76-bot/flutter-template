import 'package:flutter/material.dart';
import 'package:my_template/shared/extensions/media_query_extension.dart';
import 'package:my_template/shared/extensions/styles_extension.dart';
import 'package:my_template/themes/app_text_style.dart';

//ignore: must_be_immutable
class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.onTap,
    required this.text,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.fontSize
  });

  final void Function() onTap;
  final String text;
  double? width;
  double? height;
  double? radius;
  Color? backgroundColor;
  Color? borderColor;
  Color? textColor;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 6.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 32),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        child: Text(
          text,
          style: AppTypography.heading8.copyWith(color: textColor ?? colors.onPrimary, fontSize: fontSize ?? 16),
        ),
      ),
    );
  }
}