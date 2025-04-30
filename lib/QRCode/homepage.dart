import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/QRCode/company_code.dart';
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
    Get.offAll(() => const CompanyCode());
  }

  void getUserInfo() async {
    final authBox = Hive.box('authBox');
    final code = authBox.get('Companycode', defaultValue: "");
    final email = authBox.get('userEmail', defaultValue: "");
    setState(() {
      companyCode = code;
      userEmail = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hello  $userEmail $companyCode")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (isScannerVisible)
              Container(
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
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  backgroundColor: Colors.amber[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(isScannerVisible ? 'close' : 'Scan Qr Code'),
                onPressed: () {
                  setState(() {
                    isScannerVisible = !isScannerVisible;
                  });
                },
              ),
            ),

            Text(
              'Scanned Data',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),

            Container(
              height: height * 0.20,
              width: width * 0.79,

              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(scannedResult),
              ),
            ),
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
                  logout();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
