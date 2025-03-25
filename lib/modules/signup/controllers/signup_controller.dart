import 'dart:developer';
import 'dart:developer' as logg;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../app_routes/routes_path.dart';
import '../../../authentication/authentication_controller.dart';
import '../../../authentication/authentication_state.dart';
import '../../../model/login_model.dart' as login;
import '../../../utils/app_constants.dart';


AuthenticationController authenticationController = Get.find();


class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool passObscureText = true.obs;
  RxBool confirmPassObscureText = true.obs;

  // Form Fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  RxBool isLoading = false.obs;

  /// 🔹 Sign up with email & password
  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      return;
    }

    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save user data to Firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "fullName": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "dob": dobController.text.trim(),
        "uid": userCredential.user!.uid,
        "pass": passwordController.text,
        "createdAt": FieldValue.serverTimestamp(),
        "provider": "email",
      });

      Map<String, dynamic> userData = {
        "fullName": fullNameController.text.trim(),
        "email": emailController.text.trim(),
        "dob": dobController.text.trim(),
        "uid": userCredential.user!.uid,
        "pass": passwordController.text,
        "createdAt": FieldValue.serverTimestamp(),
        "provider": "email",
      };


      // Save user data to GetStorage
      GetStorage box = GetStorage("Auth");
      box.write('user', userCredential.user);
      // box.write(AppConstants, userCredential['fcm_token']);

      // Update authentication state
      login.LoginModel loginModel = login.LoginModel.fromJson(userData);
      authenticationController.state = Authenticated(user: loginModel);

      Get.snackbar("Success", "Signup successful!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    } on FirebaseAuthException catch (e) {
      // Check if the error is a FirebaseAuthException and display the message
      String errorMessage = e.message ?? e.toString().replaceAll(RegExp(r'\[.*?\]'), '');
      Get.snackbar(
        "Error",
        errorMessage,
        colorText: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
      );
    } catch (e) {
      // If it's a different type of error, just display the error string
      Get.snackbar(
        "Error",
        e.toString().replaceAll(RegExp(r'\[.*?\]'), ''), // Remove brackets if necessary
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }finally {
      isLoading.value = false;
    }
  }



  Future<void> signUpWithGoogle() async {
    try {
      isLoading.value = true;

      // Initialize Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        return; // User canceled sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Authenticate with Firebase
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user == null || user.email == null || user.email!.isEmpty) {
        isLoading.value = false;
        return;
      }

      // Firestore reference
      final DocumentReference userRef = FirebaseFirestore.instance.collection("Users").doc(user.uid);
      final DocumentSnapshot userDoc = await userRef.get();

      String? fcmToken; // Assign FCM token if applicable
      Map<String, dynamic> userData = {
        "provider_key": user.providerData[0].uid,
        "provider": "google",
        "name": user.displayName ?? "",
        "email": user.email ?? "",
        "avatar": user.photoURL ?? "",
        "fcm_token": fcmToken ?? ""
      };

      if (!userDoc.exists) {
        // Store new user details in Firestore
        await userRef.set(userData);
      }

      // Save user data to GetStorage
      GetStorage box = GetStorage("Auth");
      box.write('user', userData);
      box.write(AppConstants.storageKeyFcmToken, userData['fcm_token']);

      // Update authentication state
      login.LoginModel loginModel = login.LoginModel.fromJson(userData);
      authenticationController.state = Authenticated(user: loginModel);

      Get.snackbar("Success", "Signed in with Google!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
      Get.toNamed(RoutesPath.homeView);
    } on FirebaseAuthException catch (e) {
      // Check if the error is a FirebaseAuthException and display the message
      String errorMessage = e.message ?? e.toString().replaceAll(RegExp(r'\[.*?\]'), '');
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } catch (e) {
      // If it's a different type of error, just display the error string
      Get.snackbar(
        "Error",
        e.toString().replaceAll(RegExp(r'\[.*?\]'), ''), // Remove brackets if necessary
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }finally {
      isLoading.value = false;
    }
  }

}
