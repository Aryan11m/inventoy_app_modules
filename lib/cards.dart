import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReusableCircleCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget pageToNavigate;

  const ReusableCircleCard({
    super.key,
    required this.icon,
    required this.label,
    required this.pageToNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // Needed for InkWell ripple to show
      color: Colors.transparent, // Keep background clean
      child: InkWell(
        borderRadius: BorderRadius.circular(12), // Optional: rounded tap area
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => pageToNavigate),
          // );
          Get.to(() => pageToNavigate);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.shade100,
                child: Icon(icon, size: 40, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
