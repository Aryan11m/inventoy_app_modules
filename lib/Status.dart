import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/main.dart';
import 'package:inventory_app/Controllers.dart';

final List<Map<String, dynamic>> approvalss = [
  {
    'year': '2024',
    'month': 'April',
    'status': 'Pending',
    'indexno.': '1',
    'od': 'FULL OD',
  },
  {
    'year': '2024',
    'month': 'May',
    'status': 'Approved',
    'indexno.': '2',
    'od': 'SHORT WFH',
  },
  {
    'year': '2024',
    'month': 'June',
    'status': 'Rejected',
    'indexno.': '3',
    'od': 'FULL OD',
  },
  {
    'year': '2025',
    'month': 'May',
    'status': 'Pending',
    'indexno.': '4',
    'od': 'SHORT WFH',
  },
  {
    'year': '2025',
    'month': 'April',
    'status': 'Approved',
    'indexno.': '5',
    'od': 'SHORT WFH',
  },
  {
    'year': '2025',
    'month': 'August',
    'status': 'Rejected',
    'indexno.': '6',
    'od': 'SHORT WFH',
  },
];

final List<String> years = <String>['2025', '2024', '2023'];
final List<String> months = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
final List<String> approvals = <String>['Pending', 'Approved', 'Rejected'];

class Approval extends StatefulWidget {
  const Approval({super.key});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  var getControllers = Get.put(Controllers());

  String? dropdownValue;
  String? dropdownValue1;
  String? dropdownValue2;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredApprovals =
        approvalss.where((item) {
          final yearMatch =
              dropdownValue == null || item['year'] == dropdownValue;
          final monthMatch =
              dropdownValue1 == null ||
              item['month'].toLowerCase() == dropdownValue1!.toLowerCase();

          final statusMatch =
              dropdownValue2 == null || item['status'] == dropdownValue2;
          return yearMatch && monthMatch && statusMatch;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Approval', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amberAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 55,
              width: width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: width * 0.40,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: const Color.fromARGB(255, 204, 193, 219),
                      //     offset: const Offset(5.0, 5.0), //Offset
                      //     blurRadius: 6.0,
                      //     spreadRadius: 2.0,
                      //   ), //BoxShadow
                      //   BoxShadow(
                      //     color: const Color.fromARGB(255, 250, 249, 249),
                      //     offset: const Offset(0.0, 0.0),
                      //     blurRadius: 0.0,
                      //     spreadRadius: 0.0,
                      //   ), //BoxShadow
                      // ],
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Year',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                      hint: Text(
                        DateFormat.y().format(DateTime.now()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      value: dropdownValue,
                      elevation: 50,
                      style: const TextStyle(color: Colors.deepPurple),

                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                        // getControllers.yearController.text = value!;
                      },
                      items:
                          years.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: width * 0.40,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Month',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                      hint: Text(
                        DateFormat.LLLL().format(DateTime.now()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      value: dropdownValue1,

                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),

                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue1 = value!;
                        });
                        // getControllers.monthController.text = value!;
                        // print(getControllers.monthController.text);
                      },
                      items:
                          months.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 55,
              width: width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: width * 0.40,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Status',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            width: 2,
                            color: Colors.black,
                            style: BorderStyle.solid,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                      hint: Text(
                        "All",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      value: dropdownValue2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),

                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue2 = value!;
                        });
                        // getControllers.approvalController.text = value!;
                      },
                      items:
                          approvals.map<DropdownMenuItem<String>>((
                            String value,
                          ) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      elevation: 15,
                      backgroundColor: Colors.blue[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        dropdownValue = null;
                        dropdownValue1 = null;
                        dropdownValue2 = null;
                      });
                    },
                    child: Text(
                      'Reset Filters',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            if (filteredApprovals.isEmpty)
              Center(
                child: Text(
                  'No Results',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            Flexible(
              child: SizedBox(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 30.0,
                  ),
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,

                      itemCount: filteredApprovals.length,

                      itemBuilder: (context, index) {
                        final plan = filteredApprovals[index];
                        final status = plan['status'] as String;
                        final statusColor = _getStatusColor(status);

                        return Padding(
                          padding: EdgeInsets.only(bottom: 36),
                          child: SizedBox(
                            height: height * 0.25,
                            width: 450,
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior:
                                  Clip.none, // Change this to Clip.none to allow overflow
                              children: [
                                Container(
                                  height: height * 0.30,
                                  width: 450,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: statusColor,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                          255,
                                          97,
                                          99,
                                          82,
                                        ),
                                        offset: const Offset(3.0, 3.0),
                                        blurRadius: 6.0,
                                        spreadRadius: 2.0,
                                      ),
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                          255,
                                          250,
                                          249,
                                          249,
                                        ),
                                        offset: const Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          '${plan['indexno.']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${plan['year']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${plan['month']}',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(height: 20),

                                      if (plan['status'] == 'Rejected')
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            'Reason: Due date passed',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left:
                                      -45, // Position to overlap the left border
                                  top: 20,
                                  child: Container(
                                    height: 35,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      color: statusColor,
                                      borderRadius: BorderRadius.circular(30),
                                      // border: Border.all(
                                      //   color: Colors.white,
                                      //   width: 2,
                                      // ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${plan['status']}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left:
                                      -45, // Position to overlap the left border
                                  top: 70,
                                  child: Container(
                                    height: 35,
                                    width: 105,

                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                        255,
                                        199,
                                        209,
                                        228,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      // border: Border.all(
                                      //   color: Colors.white,
                                      //   width: 2,
                                      // ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${plan['od']}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(
                                            255,
                                            90,
                                            51,
                                            51,
                                          ),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
