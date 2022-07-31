import 'package:flutter_template/screens/app/home.dart';
import 'package:flutter_template/screens/onboarding/onboarding.dart';
import 'package:flutter_template/screens/screens.dart';
import 'package:get/route_manager.dart';

class AppRoutes {
  static const root = "/root";
  static const onbaording = "/onbaording";
  static const auth = '/auth';
  static const home = '/home';

  static final List<GetPage> pages = [
    GetPage(
      name: root,
      page: () {
        return RootScreen();
      },
    ),
    GetPage(
      name: home,
      page: () {
        return HomeScreen();
      },
    ),
    GetPage(
      name: auth,
      page: () {
        return const AuthScreen();
      },
    ),
    GetPage(
      name: onbaording,
      page: () {
        return const OnboardingScreen();
      },
    ),
  ];
}
