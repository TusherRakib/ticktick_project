import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constraints.dart';
import '../../../widgets/app_back_button.dart';
import '../controllers/signup_controller.dart';

class SignupPage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.fontWhite,
        title: Text(
          "Sign Up",
          style: Get.textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w800),
        ),
        leading: AppBackButton(
          onTap: () {},
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppConstrains.height50,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: controller.fullNameController,
                  decoration: const InputDecoration(
                    hintText: 'Full Name*',
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
                child: TextField(
                  controller: controller.dobController,
                  readOnly: true, // Prevent direct typing
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.dobController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format as YYYY-MM-DD
                      log(controller.dobController.text);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Date Of Birth*',
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
                    controller: controller.confirmPasswordController,
                    obscureText: controller.passObscureText.value,
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
                          controller.passObscureText.value = !controller.passObscureText.value;
                        },
                        icon: Icon(
                          controller.passObscureText.value ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Obx(
                      () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.passObscureText.value,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password*',
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
                          controller.confirmPassObscureText.value = !controller.confirmPassObscureText.value;
                        },
                        icon: Icon(
                          controller.confirmPassObscureText.value ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Column(
                children: [
                  ElevatedButton(
                    onPressed: controller.signUp,
                    child: Text("Sign Up"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: controller.signUpWithGoogle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/icon/ic_google.png', height: 20),
                        SizedBox(width: 10),
                        Text("Sign Up with Google"),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
