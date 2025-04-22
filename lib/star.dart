import 'package:flutter/material.dart';

class StarPage extends StatelessWidget {
  const StarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Star Page')),
      body: Center(child: Text('Welcome to the Star Page')),
    );
  }
}
