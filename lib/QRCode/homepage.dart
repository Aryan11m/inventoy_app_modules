import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/QRCode/api.dart';
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
  String userName = "";
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
    Get.offAll(() => const CompanyCode());
    // Get.off(() => const MyWidget());
  }

  void getUserInfo() async {
    final authBox = Hive.box('authBox');
    final code = authBox.get('companyCode', defaultValue: "");
    final name = authBox.get('userName', defaultValue: "");
    setState(() {
      companyCode = code;
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello  $userName ($companyCode)"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.black,
          // shadows: [
          //   Shadow(
          //     blurRadius: 5,
          //     color: const Color.fromARGB(255, 143, 145, 145),
          //     offset: Offset(2, 2),
          //   ),
          // ],
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
                        height: height * 0.38,
                        width: width * 0.85,

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
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          backgroundColor: Colors.amber[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.qr_code_scanner_outlined,
                          size: 33,
                        ),

                        // child: Text(
                        //   isScannerVisible ? 'Close' : 'Scan Qr Code',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w900,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        onPressed: () {
                          setState(() {
                            isScannerVisible = !isScannerVisible;
                            scannedResult = '';
                          });
                        },
                        label: Text(
                          isScannerVisible ? 'Close' : 'Scan Qr Code',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
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
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            scannedResult,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            if (isScannerVisible)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        backgroundColor: Colors.amber[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          Get.to(MyWidget());
                          scannedResult = '';
                        });
                      },
                      child: Text('Clear'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
