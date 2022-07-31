import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential?> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static Future<UserCredential?> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static void sendEmailVerification() {
    try {
      _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static Future<void> phoneSignIn(String phoneNumber) async {
    final TextEditingController otpController = TextEditingController();

    try {
      if (kIsWeb) {
        // Web Only
        ConfirmationResult result = await _auth.signInWithPhoneNumber(
          phoneNumber,
        );

        Get.defaultDialog(
          barrierDismissible: true,
          title: 'Confirm OTP',
          textCancel: 'Cancel',
          textConfirm: 'Confirm',
          onConfirm: () async {
            try {
              final PhoneAuthCredential credential =
                  PhoneAuthProvider.credential(
                verificationId: result.verificationId,
                smsCode: otpController.text,
              );
              await _auth.signInWithCredential(credential);
              // TODO: create user profile
              Get.back();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'invalid-verification-code') {
                Get.back();
                Get.snackbar('FirebaseAuthException', e.message!);
              }
            }
          },
          content: Column(children: [TextField(controller: otpController)]),
        );
      } else {
        // For ANDROID & IOS Only
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            try {
              await _auth.signInWithCredential(credential);
            } on FirebaseAuthException catch (e) {
              Get.snackbar('Firebase Auth Exception', e.message!);
            }
          },
          verificationFailed: (FirebaseAuthException error) {
            Get.snackbar('Phone number verification error', error.message!);
          },
          codeSent: (String verificationId, int? resendToken) async {
            Get.defaultDialog(
              barrierDismissible: true,
              title: 'Confirm OTP',
              textCancel: 'Cancel',
              textConfirm: 'Confirm',
              onConfirm: () async {
                try {
                  final PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text,
                  );
                  await _auth.signInWithCredential(credential);
                  // TODO: create user profile
                  Get.back();
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'invalid-verification-code') {
                    Get.back();
                    Get.snackbar('FirebaseAuthException', e.message!);
                  }
                }
              },
              content: Column(children: [TextField(controller: otpController)]),
            );
          },
          codeAutoRetrievalTimeout: (String l) {
            // TODO
          },
        );
      }
    } on FirebaseAuthException {
      rethrow;
    }
  }

  static void signOut() {
    try {
      _auth.signOut();
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
