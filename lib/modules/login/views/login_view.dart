import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_routes/routes_path.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constraints.dart';
import '../../../widgets/app_back_button.dart';
import '../../../widgets/app_button.dart';
import '../controllers/login_controller.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.fontWhite,
        title: Text(
          "Login",
          style: Get.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppConstrains.height50,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: 'Email Address*',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.obscureText.value,
                  decoration: InputDecoration(
                    hintText: 'Password*',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.zero,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.obscureText.value = !controller.obscureText.value;
                      },
                      icon: Icon(
                        controller.obscureText.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                elevation: 0.0,
                child: Text(
                  "LOGIN",
                  style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
                onTap: () {
                  if (controller.emailController.text == "") {
                    Get.snackbar("Alert!", "Email Address can not be empty!", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
                  } else if (controller.passwordController.text == "") {
                    Get.snackbar("Alert!", "Password can not be empty!", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
                  } else {
                    controller.loginMethod();
                  }
                },
              ),
            ),
            AppConstrains.height20,
            Container(
              alignment: Alignment.bottomCenter,
              child: AppButton(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                elevation: 0.0,
                child: Text(
                  "SIGN UP",
                  style: Get.textTheme.headlineSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                ),
                onTap: () {
                  // if (controller.emailController.text == "") {
                  //   Get.snackbar("Alert!", "Email Address can not be empty!", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
                  // } else if (controller.passwordController.text == "") {
                  //   Get.snackbar("Alert!", "Password can not be empty!", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
                  // } else {
                  //   controller.login();
                  // }

                  Get.toNamed(RoutesPath.signUpView);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
