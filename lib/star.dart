import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class StarPage extends StatefulWidget {
  const StarPage({super.key});

  @override
  State<StarPage> createState() => _StarPageState();
}

class _StarPageState extends State<StarPage> {
  void cancel() {
    final authBox = Hive.box('authBox');

    authBox.put('status', false);
    // Force flush to ensure it's written to storage
    authBox.flush();
    setState(() {});
    print("Canceled, status set to: ${authBox.get('status')}"); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star Page')),
      body: Column(
        children: [
          Center(child: Text('Welcome to the Star Page')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              backgroundColor: const Color.fromARGB(255, 238, 238, 234),
            ),
            onPressed: () {
              cancel();
              setState(() {});
              // Navigate back to update the main page
              Get.back();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
            //  ElevatedButton(
            //         onPressed: MyHomePage.logout(),
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor: Colors.red,
            //         ),
            //         child: const Text('Logout'),
            //       ),
        ],
      ),
    );
  }
}
