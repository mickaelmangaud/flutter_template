import 'package:flutter/material.dart';
import 'package:flutter_template/controllers/auth.dart';
import 'package:flutter_template/helpers/helpers.dart';
import 'package:flutter_template/screens/root.dart';
import 'package:flutter_template/screens/screens.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageViewController = PageController(initialPage: 0);
  final _authController = Get.put(AuthController());

  final List<Widget> pages = [
    Container(color: AppColors.darkGrey),
    Container(color: AppColors.green),
    Container(color: AppColors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _pageViewController, children: pages),
      bottomSheet: Container(
        // TODO: dimension
        padding: const EdgeInsets.symmetric(horizontal: 28),
        height: 100,
        color: Colors.grey[300],
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                _authController.passedOnboarding = true;
                Get.offAll(() => RootScreen());
              },
              child: _authController.isAuthenticated
                  ? const Text('SKIP')
                  : const Text('LOGIN'),
            ),
            InkWell(
              onTap: () => _pageViewController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}
