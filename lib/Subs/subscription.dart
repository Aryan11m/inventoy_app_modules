import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:inventory_app/page.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:inventory_app/main.dart';
import 'package:get/get.dart';
// import 'package:inventory_app/star.dart';

class Subscription1 extends StatefulWidget {
  const Subscription1({super.key});

  @override
  State<Subscription1> createState() => _Subscription1State();
}

class _Subscription1State extends State<Subscription1> {
  bool isSubscribed = false;
  late Box authBox;
  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      'title': 'Silver',
      'price': '200',
      'discount': '',
      'planDuration': 'Monthly',
    },
    {
      'title': 'Gold',
      'price': '1200',
      'discount': 'Save 15%',
      'planDuration': 'Semi-anually',
    },
    {
      'title': 'Platinum',
      'price': '2200',
      'discount': 'Save 20%',
      'planDuration': 'Anually',
    },
  ];

  @override
  void initState() {
    super.initState();
    authBox = Hive.box('authBox');
    // Check current status on init
    isSubscribed = authBox.get('status', defaultValue: false);
    print(
      "Subscription page opened, current status: $isSubscribed",
    ); // Debug print
  }

  // Updated status method to be more reliable
  void status() {
    authBox.put('status', true);
    // Force flush to ensure it's written to storage
    authBox.flush();
    setState(() {
      isSubscribed = true;
    });
    print("Subscribed, status set to: ${authBox.get('status')}"); // Debug print
  }

  // Enhanced cancel method
  void cancel() {
    authBox.put('status', false);
    // Force flush to ensure it's written to storage
    authBox.flush();
    setState(() {
      isSubscribed = false;
    });
    print("Canceled, status set to: ${authBox.get('status')}"); // Debug print
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: height * 0.9,
        width: width * 1,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          children: [
            Center(
              child: GradientText(
                'Subscribe',
                style: TextStyle(fontSize: 40),
                colors: [
                  Colors.black,
                  const Color.fromARGB(255, 20, 198, 204),
                  const Color.fromARGB(255, 209, 19, 19),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: subscriptionPlans.length,
              itemBuilder: (context, index) {
                final plan = subscriptionPlans[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 240, 200, 83),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        if (plan['discount'] != null)
                          Align(
                            alignment: Alignment.topRight,

                            child: Text(
                              plan['discount'],

                              style: TextStyle(
                                fontSize: 10,
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ),
                        Text(
                          '${plan['title']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.currency_rupee_outlined, size: 38),
                            Text(
                              '${plan['price']}',
                              style: TextStyle(fontSize: 40),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            status();
                            final authBox = Hive.box('authBox');

                            authBox.put('status', true);

                            isSubscribed = true;

                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(
                                10,
                              ),
                            ),
                          ),

                          child: Text('Subscribe ${plan['planDuration']}'),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  backgroundColor: const Color.fromARGB(255, 238, 238, 234),
                ),
                onPressed: () {
                  cancel();
                  Get.back();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
