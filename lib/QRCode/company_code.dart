import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventory_app/QRCode/login1.dart';
import 'package:hive/hive.dart';

class CompanyCode extends StatefulWidget {
  const CompanyCode({super.key});

  @override
  State<CompanyCode> createState() => _CompanyCodeState();
}

class _CompanyCodeState extends State<CompanyCode> {
  final _formKeys = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   // Load user info from Hive
  //   getUserCode();
  // }

  // void getUserCode(){

  // },

  void login() {
    if (_formKeys.currentState!.validate()) {
      String code = codeController.text;
      // final now = DateTime.now();
      final authBox = Hive.box('authBox');

      authBox.put('companyCode', code);
      Get.offAll(LoginPage());
    }
  }

  String? _validateCode(String? value) {
    if (value == null || value.isEmpty) return 'This field is empty';
    // if (value.length < 6) return 'Password must be of atleast 6 characters';
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
                // Image.asset(
                //   'assets/images/logo.png',
                //   height: height * 0.35,
                //   width: width * 0.75,
                //   color: const Color.fromARGB(255, 247, 244, 244),
                //   colorBlendMode: BlendMode.multiply,
                //   fit: BoxFit.fill,
                // ),
                const Text(
                  'Invento',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 34),

                TextFormField(
                  controller: codeController,
                  validator: _validateCode,
                  decoration: const InputDecoration(
                    labelText: 'Enter Company Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 50),

                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(255, 238, 238, 234),
                  ),
                  onPressed: () {
                    login();
                  },
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
