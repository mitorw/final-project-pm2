import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcalc Reset Password'),
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
                  border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF1B5E20)),
                      ),
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
                child: const Text(
                      'Send Reset Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20), // Warna hijau
                      minimumSize:
                          const Size(double.infinity, 48), // Ukuran tombol
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Radius yang sama dengan TextField
                      ),
                    ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
