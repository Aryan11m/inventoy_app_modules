
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import 'package:inventory_app/QRCode/model.dart/datacontroller.dart';
import 'package:inventory_app/QRCode/model.dart/getmodel.dart';
import 'package:inventory_app/QRCode/model.dart/pdf.dart';
// import 'package:inventory_app/QRCode/model.dart/getmodel.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final getDataController = Get.put(GetDataController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataController.getDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Getx List'),
          centerTitle: true,
          backgroundColor: Colors.amber[200],
        ),
        body: Column(
          children: [
            !getDataController.isLoading.value
                ? Expanded(
                  child: ListView.builder(
                    itemCount:
                        getDataController.LeaveApproval.value.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          // leading: ClipRRect(
                          //   borderRadius: BorderRadius.circular(80),
                          //   child: Image.network(
                          //     getDataController
                          //         .LeaveApproval
                          //         .value
                          //         .superheros[index]
                          //         .url,
                          //     fit: BoxFit.fitHeight,

                          //     height: 50,
                          //     width: 50,
                          //   ),
                          // ),
                          title: Text(
                            getDataController
                                .LeaveApproval
                                .value
                                .superheros[index]
                                .name,
                          ),
                          subtitle: Text(
                            getDataController
                                .LeaveApproval
                                .value
                                .superheros[index]
                                .power,
                          ),
                        ),
                      );
                    },
                  ),
                )
                : Center(child: CircularProgressIndicator()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                backgroundColor: Colors.amber[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  Get.to(Pdd(title: "PDF"));
                });
              },
              child: Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}
