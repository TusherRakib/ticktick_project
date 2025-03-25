import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    this.buttonColor,
    required this.onTap,
  }) : super(key: key);

  final void Function() onTap;

  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Get.back();
      },
      icon: Image.asset(
        "assets/icon/ic_subtract.png",
        height: 19,
        color: buttonColor,
      ),
    );
  }
}
