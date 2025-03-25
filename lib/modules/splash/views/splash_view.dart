import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: Image.asset("assets/images/img_ticktick.jpeg"),
          // child: Text("TickTick", style: TextStyle(color: AppColors.orange,fontSize: 20, ),),
        ),
      ),
    );
  }
}
