// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   Future<List<dynamic>>? futureData;

//   @override
//   void initState() {
//     super.initState();
//     futureData = getData();
//   }

//   Future<List<dynamic>> getData() async {
//     try {
//       var response = await Dio().get(
//         // 'https://protocoderspoint.com/jsondata/superheros.json',
//         'https://681d8491f74de1d219b00427.mockapi.io/api/trial',
//       );
//       if (response.statusCode == 200) {
//         return response.data['trial'] as List;
//       } else {
//         throw Exception(
//           'Failed to load data - Status code: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Future Builder', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: FutureBuilder<List<dynamic>>(
//         future: futureData ?? getData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No data available'));
//           } else {
//             final jsonList = snapshot.data!;
//             return ListView.builder(
//               itemCount: jsonList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   child: ListTile(
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(80),
//                       // child: Image.network(
//                       //   jsonList[index]['url'],
//                       //   fit: BoxFit.fill,
//                       //   width: 50,
//                       //   height: 50,
//                       // ),
//                     ),
//                     title: Text(jsonList[index]['username']),
//                     subtitle: Text(jsonList[index]['description']),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:dio/dio.dart';
import 'package:inventory_app/QRCode/model.dart/datacontroller.dart';
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
        appBar: AppBar(title: Text('Getx List')),
        body: Column(
          children: [
            !getDataController.isLoading.value
                ? Expanded(
                  child: ListView.builder(
                    itemCount:
                        getDataController.welcome.value.superheros.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          // leading: ClipRRect(
                          //   borderRadius: BorderRadius.circular(80),
                          //   child: Image.network(
                          //     getDataController
                          //         .welcome
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
                                .welcome
                                .value
                                .superheros[index]
                                .name,
                          ),
                          subtitle: Text(
                            getDataController
                                .welcome
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
                  Get.to(Pdd(title: 'ABC'));
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
