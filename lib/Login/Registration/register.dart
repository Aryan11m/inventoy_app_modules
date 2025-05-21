import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/Controllers.dart';
import 'package:inventory_app/Login/Registration/validators.dart';
import 'login1.dart';

//
class registerationPage extends StatefulWidget {
  // static var confirmPasswordController;

  const registerationPage({super.key});

  @override
  State<registerationPage> createState() => _registerationPageState();
}

class _registerationPageState extends State<registerationPage> {
  final _formKeys = GlobalKey<FormState>();
  var getControllers = Get.put(Controllers());

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController confirmPasswordController =
  //     TextEditingController();

  // String? validateName(String? value) {
  //   if (value == null || value.isEmpty) return "Enter Your Name";
  //   final nameRegex = RegExp('[a-zA-Z]');
  //   if (!nameRegex.hasMatch(value)) {
  //     return "Enter Valid Name";
  //   }
  //   return null;
  // }

  // String? validatePhone(String? value) {
  //   if (value == null || value.isEmpty) return "Enter Your Phone Number";
  //   final phoneRegex = RegExp(r"^\d+$");
  //   if (!phoneRegex.hasMatch(value) || value.length < 10) {
  //     return "Enter  valid 10 digit mobile number";
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeys,
            child: Column(
              children: [
                const SizedBox(height: 20),

                const SizedBox(height: 20),

                TextFormField(
                  controller: getControllers.nameController,
                  validator: Validator.validateName,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: getControllers.phoneController,
                  validator: Validator.validatePhone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
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
                    labelText: 'Password',
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
                    signUp();
                  },
                  child: Text('Sign Up'),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  child: Text(
                    "Already have an account? Sign-In",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  onTap: () {
                    Get.to(LoginPage());
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() {
    if (_formKeys.currentState!.validate()) {}
    String name1 = getControllers.nameController.text;
    String phone = getControllers.phoneController.text;
    print("Name :$name1");
    print("Phone: $phone");
  }
}
