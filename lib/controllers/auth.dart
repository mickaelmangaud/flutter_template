import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template/firebase/auth_service.dart';
import 'package:flutter_template/firebase/user_service.dart';
import 'package:flutter_template/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _currentUser = (FirebaseAuth.instance.currentUser).obs;
  final _user = UserModel().obs;
  final _storage = GetStorage();
  final _passedOnboarding = false.obs;

  UserModel get user => _user.value;
  bool get passedOnboarding => _passedOnboarding.value;
  set passedOnboarding(bool passed) {
    _storage.write('passedOnboarding', passed);
    _passedOnboarding.value = passed;
  }

  bool get isAuthenticated => _currentUser.value != null && user.email != null;

  @override
  void onInit() {
    super.onInit();
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    /* Loads the user from storage */
    if (_storage.read('user') != null) {
      print(_storage.read('user'));
      _user.value = UserModel.fromJson(_storage.read('user'));
    }

    if (_storage.read('passedOnboarding') != null) {
      passedOnboarding = _storage.read('passedOnboarding');
    }
  }

  void clear() {
    _user(UserModel());
  }

  void registerWithEmail(String email, String password) async {
    try {
      final credential = await AuthService.registerWithEmail(
        email,
        password,
      );

      if (credential?.user != null) {
        final UserModel? newUser = await UserService.createUser(
          credential!.user!.uid,
          UserModel(
            email: email,
            uid: credential.user!.uid,
          ),
        );
        _user(newUser!);
        _storage.write('user', newUser);

        if (!credential.user!.emailVerified) {
          AuthService.sendEmailVerification();
        }
        Get.snackbar('Firebase Auth', 'User creeated');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Firebase Auth Exception', e.message!);
    }
  }

  void signInWithEmail(String email, String password) async {
    try {
      final UserCredential? credential = await AuthService.signInWithEmail(
        email,
        password,
      );

      if (credential!.user != null) {
        final UserModel? existingUser = await UserService.getUser(
          credential.user!.uid,
        );

        if (existingUser != null) {
          _user(existingUser);
          _storage.write('user', existingUser);

          if (!credential.user!.emailVerified) {
            AuthService.sendEmailVerification();
            Get.snackbar('Firebase Auth', 'Email verification sent');
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Firebase Auth Exception', e.message!);
      signOut();
      clear();
      return null;
    }
  }

  void signInByPhoneNumber(String phoneNumber) {
    try {
      AuthService.phoneSignIn(phoneNumber);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Firebase Auth Exception', e.message!);
    }
  }

  void signOut() {
    try {
      _storage.remove('user');
      AuthService.signOut();
      clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Firebase Auth Exception', e.message!);
    }
  }
}
