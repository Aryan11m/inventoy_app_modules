import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/QRCode/api.dart';
import 'package:inventory_app/main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  // final qrKey = GlobalKey();
  bool isScannerVisible = false;
  late String scannedResult = "";
  String companyCode = "";
  String userEmail = "";
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    // Load user info from Hive
    getUserInfo();
  }

  void logout() {
    // Set the user as logged out
    final authBox = Hive.box('authBox');
    authBox.put('isLoggedIn', false);

    // Navigate to login page
    // Get.offAll(() => const CompanyCode());
    Get.off(() => const MyWidget());
  }

  void getUserInfo() async {
    final authBox = Hive.box('authBox');
    final code = authBox.get('companyCode', defaultValue: "");
    final email = authBox.get('userEmail', defaultValue: "");
    setState(() {
      companyCode = code;
      userEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello  $userEmail $companyCode"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    if (isScannerVisible)
                      SizedBox(
                        height: height * 0.4,
                        width: width * 0.70,
                        child: MobileScanner(
                          onDetect: (capture) {
                            final List<Barcode> barcodes = capture.barcodes;
                            for (final barcode in barcodes) {
                              setState(() {
                                (scannedResult =
                                    barcode.rawValue ?? "No Data found in QR");
                              });
                            }
                          },
                        ),
                      ),

                    SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          backgroundColor: Colors.amber[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          isScannerVisible ? 'Close' : 'Scan Qr Code',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isScannerVisible = !isScannerVisible;
                            scannedResult = '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (isScannerVisible)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        'Scanned Data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        height: height * 0.17,
                        width: width * 0.79,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            scannedResult,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      // SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 10,
                          ),
                          backgroundColor: Colors.amber[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Logout'),
                        onPressed: () {
                          setState(() {
                            logout();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
