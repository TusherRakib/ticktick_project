import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      this.height,
      this.buttonColor,
      this.child,
      this.onTap,
      this.solid = true,
      this.padding,
      this.borderColor,
      this.borderWidth,
      this.width,
      this.elevation,
      this.radius,
      this.disableColor,
      this.margin})
      : super(key: key);

  final Widget? child;

  final void Function()? onTap;
  final bool solid;
  final EdgeInsets? padding;
  final Color? borderColor;
  final Color? disableColor;
  final double? borderWidth;
  final double? width;
  final double? height;
  final double? radius;
  final Color? buttonColor;
  final double? elevation;

  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width,
      height: height ?? 53,
      margin: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disableColor, backgroundColor: solid ? buttonColor ?? AppColors.green : Colors.white,
            elevation: elevation ?? 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 0.0),
              side: BorderSide(
                color: !solid
                    ? borderColor != null
                        ? borderColor!
                        : AppColors.green
                    : Colors.transparent,
              ),
            )),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0.0),
          child: child,
        ),
      ),
    );
  }
}
