import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordController extends GetxController {
  // FirebaseAuth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  // TextEditingController untuk mengelola input email
  final emailController = TextEditingController();

  // Variable untuk melacak status loading
  var isLoading = false.obs;

  // Function untuk mengirim reset password email
  void sendResetPasswordEmail() async {
    final email = emailController.text;

    if (email.isEmpty || !GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return;
    }

    isLoading(true);

    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
        title: "Success",
        middleText: "Password reset email sent to $email",
        onConfirm: () {
          Get.back(); // Close dialog
          Get.back(); // Back to previous screen
        },
        textConfirm: "OK",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to send password reset email.",
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
