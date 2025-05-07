// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   var jsonList;
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   Future<void> getData() async {
//     try {
//       var response = await Dio().get(
//         'https://protocoderspoint.com/jsondata/superheros.json',
//       );
//       if (response.statusCode == 200) {
//         setState(() {
//           jsonList = response.data['superheros'] as List;
//         });
//       } else {
//         print(response.statusCode);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GeeksForGeeks', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: jsonList == null ? 0 : jsonList.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               child: ListTile(
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(80),
//                   // child: Image.network(
//                   //   jsonList[index]['url'],
//                   //   fit: BoxFit.fitWidth,
//                   //   width: 50,
//                   //   height: 50,
//                   // ),
//                 ),
//                 title: Text(jsonList[index]['name']),
//                 subtitle: Text(jsonList[index]['power']),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Future<List<dynamic>>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = getData();
  }

  Future<List<dynamic>> getData() async {
    try {
      var response = await Dio().get(
        'https://protocoderspoint.com/jsondata/superheros.json',
      );
      if (response.statusCode == 200) {
        return response.data['superheros'] as List;
      } else {
        throw Exception(
          'Failed to load data - Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Future Builder', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureData ?? getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final jsonList = snapshot.data!;
            return ListView.builder(
              itemCount: jsonList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.network(
                        jsonList[index]['url'],
                        fit: BoxFit.fill,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    title: Text(jsonList[index]['name']),
                    subtitle: Text(jsonList[index]['power']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
