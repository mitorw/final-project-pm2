import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            children: [
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.sendResetPasswordEmail();
                      },
                child: controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Send Reset Email'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
