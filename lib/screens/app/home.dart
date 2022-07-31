import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final storage = GetStorage();

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            Obx(() => Text('${_authController.user.email}')),
            OutlinedButton(
              onPressed: () => _authController.signOut(),
              child: const Text('SignOut'),
            ),
            OutlinedButton(
              onPressed: () => _authController.passedOnboarding = false,
              child: const Text('Clear storage passedOnboarding'),
            ),
          ],
        ),
      ),
    );
  }
}
