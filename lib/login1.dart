import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/page.dart';
import 'package:inventory_app/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeys = GlobalKey<FormState>();
  bool isChecked = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // late Box forlog1;
  late Box authBox;

  @override
  void initState() {
    super.initState();
    createBox();
  }

  void createBox() async {
    // forlog1 = await Hive.openBox('logindata');
    authBox = await Hive.openBox('authBox');
    getData();
  }

  void getData() async {
    if (authBox.get('email') != null) {
      emailController.text = authBox.get('email');
      isChecked = true; // If email exists, "Remember Me" was checked
      setState(() {});
    }
    if (authBox.get('password') != null) {
      passwordController.text = authBox.get('password');
    }
  }

  String selectedRole = 'User';
  final List<String> roles = ['User', 'Manager', 'Admin'];

  void login() {
    if (_formKeys.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;
      final now = DateTime.now();

      // Save login credentials if "Remember Me" is checked
      login1();

      // Always set the user as logged in when successfully logging in
      authBox.put('isLoggedIn', true);
      authBox.put('userEmail', email);
      authBox.put('userRole', selectedRole);
      authBox.put('rememberMe', isChecked);
      authBox.put('lastLoginTime', now.toString());

      Get.off(() => const MyHomePage());

      print('Role: $selectedRole');
      print('Email: $email');
      print('Password: $password');
      print('LoggedInTime: $now');
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter valid email id';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 6) return 'Password must be of atleast 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKeys,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: height * 0.35,
                  width: width * 0.75,
                  color: const Color.fromARGB(255, 247, 244, 244),
                  colorBlendMode: BlendMode.multiply,
                  fit: BoxFit.fill,
                ),
                const Text(
                  'Invento',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 34),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items:
                      roles.map((role) {
                        return DropdownMenuItem(value: role, child: Text(role));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Role',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  validator: _validateEmail,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: _validatePassword,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remember Me',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 43,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.blueGrey[300],
                  ),
                  child: const Text('login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login1() {
    if (isChecked) {
      // Save email and password if "Remember Me" is checked
      authBox.put('email', emailController.text);
      authBox.put('password', passwordController.text);
    } else {
      // Clear saved credentials if "Remember Me" is unchecked
      authBox.delete('email');
      authBox.delete('password');
    }
  }
}
