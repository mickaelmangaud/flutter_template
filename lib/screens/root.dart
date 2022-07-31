import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/controllers.dart';
import 'package:flutter_template/screens/app/home.dart';
import 'package:flutter_template/screens/onboarding/onboarding.dart';
import 'package:flutter_template/screens/screens.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  RootScreen({Key? key}) : super(key: key);

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _authController.isAuthenticated
          ? HomeScreen()
          : _authController.passedOnboarding
              ? const AuthScreen()
              : const OnboardingScreen(),
    );
  }
}
