import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../../../app_routes/routes_path.dart';
import '../../../authentication/authentication_state.dart';
import '../../../model/login_model.dart' as login;
import '../../../app_network/authentication_api.dart';
import '../../../utils/app_constants.dart';
class LogInController extends GetxController {
  RxBool obscureText = true.obs;

  RxString otp = ''.obs;

  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> loginMethod() async {
    try {
      isLoading.value = true;

      log(emailController.text.trim());
      log(passwordController.text.trim());
      // Sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      log(userCredential.user!.toString());
      // Get user data from Firestore
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(userCredential.user!.uid).get();
      final DocumentReference userRef = FirebaseFirestore.instance.collection("Users").doc(userCredential.user?.uid);
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Verify the password field in Firestore
        if (userData["pass"] == passwordController.text.trim()) {

          User user = userCredential.user!;
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


          Get.snackbar("Success", "Login successful!",
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);

          Get.offAllNamed(RoutesPath.homeView); // Navigate to home screen
        } else {
          Get.snackbar("Error", "Incorrect password",
              snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        }
      } else {
        Get.snackbar("Error", "User data not found",
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      Get.snackbar("Login Error", e.message ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }


  showLoaderDialog() {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> authenticate() async {
    try {
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;

      if (canCheckBiometrics) {
        List<BiometricType> availableBiometrics = await _localAuth.getAvailableBiometrics();

        if (availableBiometrics.contains(BiometricType.fingerprint)) {
          bool authenticated = await _localAuth.authenticate(
              localizedReason: 'Authenticate to access the app with Face ID', options: const AuthenticationOptions(biometricOnly: true));

          if (authenticated) {
            log('Face ID authenticated');
          } else {
            log('Face ID authentication failed');
          }
        }
        if (availableBiometrics.contains(BiometricType.face)) {
          bool authenticated = await _localAuth.authenticate(
              localizedReason: 'Authenticate to access the app with Face ID', options: const AuthenticationOptions(biometricOnly: true));

          if (authenticated) {
            log('Face ID authenticated');
          } else {
            log('Face ID authentication failed');
          }
        } else {
          Get.snackbar("Oops!", "Face ID is not available");
        }
      } else {
        log('Biometrics not available');
      }
    } on PlatformException catch (e) {
      log('Error: $e');
    }
  }
}
