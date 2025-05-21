import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers.dart';
// import 'package:inventory_app/register.dart';
// import 'login1.dart';
import 'validators.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _formKeys = GlobalKey<FormState>();
  var getControllers = Get.put(Controllers());

  void submit() {
    if (_formKeys.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKeys,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Forgot Password',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: getControllers.emailController,
                    validator: Validator.validateEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: getControllers.passwordController,
                    validator: Validator.validatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter New Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: getControllers.confirmPasswordController,
                    validator: Validator.confirmPassword1,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Re-enter Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 10),
                    onPressed: () {
                      submit();
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
