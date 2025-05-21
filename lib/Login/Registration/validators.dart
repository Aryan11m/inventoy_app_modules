// import 'package:flutter/material.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter valid email id';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 6) return 'Password must be of atleast 6 characters';
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Enter Your Name";
    final nameRegex = RegExp(r"^[a-zA-Z]+$");
    if (!nameRegex.hasMatch(value)) {
      return "Enter Valid Name";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Enter Your Phone Number";
    final phoneRegex = RegExp(r"^\d+$");
    if (!phoneRegex.hasMatch(value) || value.length < 10) {
      return "Enter  valid 10 digit mobile number";
    }
    return null;
  }

  static String? confirmPassword1(String? value) {
    if (value == null || value.isEmpty) return "Enter Password";
    if (value != validatePassword(value)) return "Password does not match";
    return null;
  }
  
}
