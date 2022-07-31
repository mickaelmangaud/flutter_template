import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_template/controllers/controllers.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authController = Get.put(AuthController());
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _password2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                icon: Icon(Icons.mail),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _password2Controller,
              decoration: const InputDecoration(
                hintText: 'Password confirmation',
                icon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              child: const Text('Create Account'),
              onPressed: () => _authController.signInWithEmail(
                _emailController.text,
                _passwordController.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
