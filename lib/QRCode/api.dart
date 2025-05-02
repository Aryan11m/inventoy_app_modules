import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventory_app/QRCode/homepage.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String data = '';

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.sampleapis.com/cartoons/cartoons2D'),
      );
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body)['title'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        data = 'error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: fetchData, child: Text('Fetch Data')),
            SizedBox(height: 20),
            Padding(padding: const EdgeInsets.all(8.0), child: Text(data)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                backgroundColor: Colors.amber[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Logout'),
              onPressed: () {
                setState(() {
                  Get.to(Scanner());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
