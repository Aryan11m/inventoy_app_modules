/*
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:inventory_app/page.dart';
import 'package:get/get.dart';
// import 'package:inventory_app/star.dart';

class Subscription1 extends StatefulWidget {
  const Subscription1({super.key});

  @override
  State<Subscription1> createState() => _Subscription1State();
}

class _Subscription1State extends State<Subscription1> {
  Razorpay razorpay = Razorpay();

  bool isSubscribed = false;
  late Box authBox;
  final List<Map<String, dynamic>> subscriptionPlans = [
    {
      'title': 'Silver',
      'price': '200',
      'planDuration': 'Monthly',
      'description': 'Perfect for small businesses',
    },
    {
      'title': 'Gold',
      'price': '1200',
      'discount': 'Save 50%',
      'planDuration': 'Semi-annually',
      'description': 'Most popular choice',
    },
    {
      'title': 'Platinum',
      'price': '2200',
      'discount': 'Save 63%',
      'planDuration': 'Annually',
      'description': 'Best value for enterprises',
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
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Choose Your Plan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Hero Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ShaderMask(
                        shaderCallback:
                            (bounds) => const LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            ).createShader(bounds),
                        child: const Text(
                          'Unlock Premium Features',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Choose the perfect plan for your business needs',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Subscription Plans
                ...subscriptionPlans.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> plan = entry.value;
                  return _buildPremiumPlanCard(plan, index);
                }).toList(),

                const SizedBox(height: 24),

                // Cancel Button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Not ready to subscribe?',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          cancel();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          foregroundColor: Colors.grey[700],
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        child: const Text(
                          'Maybe Later',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumPlanCard(Map<String, dynamic> plan, int index) {
    // Define colors for each plan
    final List<List<Color>> planColors = [
      [const Color(0xFF8B5CF6), const Color(0xFFA855F7)], // Purple for Silver
      [const Color(0xFFEAB308), const Color(0xFFF59E0B)], // Gold for Gold
      [const Color(0xFF06B6D4), const Color(0xFF0891B2)], // Cyan for Platinum
    ];

    final List<Color> currentColors = planColors[index % planColors.length];
    final bool isPopular = index == 1; // Make Gold plan popular

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border:
                  isPopular
                      ? Border.all(color: currentColors[0], width: 2)
                      : Border.all(color: Colors.grey[200]!, width: 1),
              boxShadow: [
                BoxShadow(
                  color:
                      isPopular
                          ? currentColors[0].withOpacity(0.2)
                          : Colors.black.withOpacity(0.08),
                  blurRadius: isPopular ? 20 : 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Plan Title with Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: currentColors),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getPlanIcon(plan['title']),
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      plan['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: currentColors[0],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Duration
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: currentColors[0].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    plan['planDuration'],
                    style: TextStyle(
                      color: currentColors[0],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: currentColors[0],
                      ),
                    ),
                    Text(
                      plan['price'],
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: currentColors[0],
                        height: 1,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Features (you can customize these)
                ..._getPlanFeatures(plan['title'])
                    .map(
                      (feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: currentColors[0],
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),

                const SizedBox(height: 24),

                // Subscribe Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: currentColors),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: currentColors[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      status();
                      final authBox = Hive.box('authBox');
                      authBox.put('status', true);
                      isSubscribed = true;
                      Get.back();

                      var options = {
                        'key': 'rzp_test_Qb9FJurfVY6ULB',
                        'amount': int.parse(plan['price']) * 100,
                        'name': 'Company Name.',
                        'description':
                            '${plan['title']} Plan - ${plan['planDuration']}',
                        'timeout': 60,
                        'prefill': {
                          'contact': '9123456789',
                          'email': 'flutterwings304@gmail.com',
                        },
                      };
                      razorpay.open(options);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Subscribe ${plan['planDuration']}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Popular Badge
          if (isPopular)
            Positioned(
              top: -8,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: currentColors),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: currentColors[0].withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'MOST POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Discount Badge
          if (plan['discount'] != null)
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  plan['discount'],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getPlanIcon(String planTitle) {
    switch (planTitle.toLowerCase()) {
      case 'silver':
        return Icons.star_border;
      case 'gold':
        return Icons.star_half;
      case 'platinum':
        return Icons.star;
      default:
        return Icons.star;
    }
  }

  List<String> _getPlanFeatures(String planTitle) {
    switch (planTitle.toLowerCase()) {
      case 'silver':
        return [
          'Basic inventory tracking',
          'Up to 100 products',
          'Email support',
          'Mobile app access',
        ];
      case 'gold':
        return [
          'Advanced inventory management',
          'Up to 1000 products',
          'Priority support',
          'Analytics dashboard',
          'Export reports',
        ];
      case 'platinum':
        return [
          'Enterprise inventory solution',
          'Unlimited products',
          '24/7 phone support',
          'Advanced analytics',
          'Custom integrations',
          'Multi-location support',
        ];
      default:
        return ['Feature 1', 'Feature 2', 'Feature 3'];
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(msg: 'Payment Successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: 'Payment Failed');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    try {
      razorpay.clear();
    } on Exception catch (e) {
      print(e);
    }
  }
}
*/
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
  Razorpay razorpay = Razorpay();

  bool isSubscribed = false;
  late Box authBox;
  final List<Map<String, dynamic>> subscriptionPlans = [
    {'title': 'Silver', 'price': '200', 'planDuration': 'Monthly'},
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
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
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
                      color: const Color.fromARGB(129, 226, 241, 228),

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
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                plan['discount'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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

                            var options = {
                              // Razorpay API Key
                              'key': 'rzp_test_Qb9FJurfVY6ULB',
                              // in the smallest
                              // currency sub-unit.
                              'amount': 10000,
                              'name': 'Company Name.',

                              'description': 'Description for order',
                              // in seconds
                              'timeout': 60,
                              'prefill': {
                                'contact': '9123456789',
                                'email': 'flutterwings304@gmail.com',
                              },
                            };
                            razorpay.open(options);
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(msg: 'Payment Successful');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: 'Payment Failed');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    try {
      razorpay.clear();
    } on Exception catch (e) {
      print(e);
    }
  }
}
