import 'package:api_task/modules/authentication/controllers/auth_controller.dart';
import 'package:api_task/utils/const/const_text.dart';
import 'package:api_task/utils/const/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthController authController = Get.put(AuthController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              "Login Screen".buildText(fontSize: 25, color: Colors.black),
              CustomTextField(
                labelText: 'Email',
                controller: emailController,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please enter email';
                  }
                  if (value?.isEmail == false) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ==  true) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.signIn(email: emailController.text, password: passwordController.text);
                  }
                },
                child: 'Login'.buildText(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: 'Don\'t have an account? Sign Up'.buildText(
                  fontSize: 16.0,
                ),
              ),
            ]).paddingSymmetric(horizontal: 30),
      ),
    );
  }
}
