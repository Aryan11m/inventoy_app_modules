/*
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getControllers.getDataFromApi();
  }

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
                  padding: const EdgeInsets.fromLTRB(50, 30, 8, 0),
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
                            width: width * 0.95,
                            child: Stack(
                              fit: StackFit.expand,
                              clipBehavior:
                                  Clip.none, // Change this to Clip.none to allow overflow
                              children: [
                                Container(
                                  height: height * 0.30,
                                  width: width * 0.95,
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
                                      -48, // Position to overlap the left border
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
                                      -48, // Position to overlap the left border
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
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/QRCode/model.dart/getmodel.dart';
import 'package:inventory_app/main.dart';
import 'package:inventory_app/QRCode/model.dart/datacontroller.dart';

final List<String> years = <String>['2025', '2024', '2023', '2022'];
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
final List<String> approvals = <String>[
  'All',
  'Pending',
  'Approved',
  'Rejected',
];

class Approval extends StatefulWidget {
  const Approval({super.key});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  final getDataController = Get.put(GetDataController());

  // Initialize with default values
  String? dropdownValue;
  String? dropdownValue1;
  String? dropdownValue2;

  Future<List<Data>>? _dataFuture;

  @override
  void initState() {
    super.initState();

    final currentDate = DateTime.now();
    dropdownValue = currentDate.year.toString();
    dropdownValue1 = DateFormat.LLLL().format(currentDate);
    dropdownValue2 = 'All';

    // Initialize data controller
    getDataController.getDataFromApi();
    getDataController.testApiMethods();

    _applyFilters();
  }

  TimeOfDay _inTime = TimeOfDay(hour: 7, minute: 15);
  TimeOfDay _outTime = TimeOfDay(hour: 7, minute: 15);

  void _selectInTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _inTime,
    );
    if (newTime != null) {
      setState(() {
        _inTime = newTime;
      });
    }
  }

  void _selectOutTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _outTime,
    );
    if (newTime != null) {
      setState(() {
        _outTime = newTime;
      });
    }
  }

  // Helper method to convert month name to number
  int _getMonthNumber(String monthName) {
    return months.indexOf(monthName) + 1;
  }

  // Method to send month data to API and get filtered data
  void _onMonthChanged(String? selectedMonth) {
    setState(() {
      dropdownValue1 = selectedMonth;
    });

    if (selectedMonth != null) {
      int monthNumber = _getMonthNumber(selectedMonth);
      getDataController.getDataByMonth(monthNumber);
      _applyFilters();
    } else {
      getDataController.getDataFromApi();
      _applyFilters();
    }
  }

  // Method to send year data to API and get filtered data
  void _onYearChanged(String? selectedYear) {
    setState(() {
      dropdownValue = selectedYear;
    });

    if (selectedYear != null) {
      int year = int.parse(selectedYear);
      getDataController.getDataByYear(year);
      _applyFilters();
    } else {
      getDataController.getDataFromApi();
      _applyFilters();
    }
  }

  // Method to send status data to API and get filtered data
  void _onStatusChanged(String? selectedStatus) {
    setState(() {
      dropdownValue2 = selectedStatus;
    });

    if (selectedStatus != null) {
      getDataController.getDataByStatus(selectedStatus);
      _applyFilters();
    } else {
      getDataController.getDataFromApi();
      _applyFilters();
    }
  }

  Future<List<Data>> _getFilteredData() async {
    Map<String, dynamic> filters = {};

    if (dropdownValue != null) {
      filters['year'] = int.parse(dropdownValue!);
    }

    if (dropdownValue1 != null) {
      filters['month'] = _getMonthNumber(dropdownValue1!);
    }

    if (dropdownValue2 != null) {
      filters['status'] = dropdownValue2!;
    }

    if (filters.isNotEmpty) {
      await getDataController.getDataWithFilters(filters);
    } else {
      await getDataController.getDataFromApi();
    }
    return getDataController.welcome.value.data ?? [];
  }

  void _applyFilters() {
    setState(() {
      _dataFuture = _getFilteredData();
    });
  }

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

  // List<Data> _getFilteredApprovals(List<Data>? apiData) {
  //   if (apiData == null) return [];
  //   return apiData;
  // }

  @override
  Widget build(BuildContext context) {
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
            // Filter dropdowns
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
                      value: dropdownValue,
                      elevation: 50,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: _onYearChanged,
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
                    width: width * 0.42,
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
                      value: dropdownValue1,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: _onMonthChanged,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      value: dropdownValue2,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      onChanged: _onStatusChanged,
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
                  SizedBox(width: width * 0.10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        // elevation: 15,
                        backgroundColor: Colors.blue[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      onPressed: () {
                        final currentDate = DateTime.now();
                        setState(() {
                          dropdownValue = currentDate.year.toString();
                          dropdownValue1 = DateFormat.LLLL().format(
                            currentDate,
                          );
                          dropdownValue2 = 'All';
                        });
                        _applyFilters();
                      },
                      child: Text(
                        'Reset Filters',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Display API data
            Expanded(
              child: FutureBuilder(
                future: _dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    );
                  }
                  final filteredApprovals = snapshot.data ?? [];
                  if (filteredApprovals.isEmpty) {
                    return Center(
                      child: Text(
                        'No Results',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(50, 30, 8, 0),
                    itemCount: filteredApprovals.length,
                    itemBuilder: (context, index) {
                      final leaveData = filteredApprovals[index];
                      final status = leaveData.status ?? 'Unknown';
                      final statusColor = _getStatusColor(status);
                      // Format dates for display
                      // String displayYear = '';
                      String displayMonth = '';
                      if (leaveData.leaveFromDate != null) {
                        try {
                          DateTime date = DateTime.parse(
                            leaveData.leaveFromDate!,
                          );
                          // displayYear = date.year.toString();
                          displayMonth = DateFormat.LLLL().format(date);
                        } catch (e) {
                          // displayYear = dropdownValue ?? 'N/A';
                          displayMonth = dropdownValue1 ?? 'N/A';
                        }
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: 36),
                        child: SizedBox(
                          height: height * 0.38,
                          width: width * 0.95,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: height * 0.35,
                                width: width * 0.95,
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
                                        '${leaveData.leaveDetailId ?? 'N/A'}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      leaveData.name ?? 'N/A',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      displayMonth,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 39),
                                    Row(
                                      children: [
                                        // In-time section
                                        Column(
                                          children: [
                                            Text(
                                              'New In-time',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: _selectInTime,
                                              icon: Icon(
                                                Icons.access_time,
                                                color: Colors.black,
                                              ),
                                              label: Text(
                                                _inTime.format(context),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Out-time section
                                        Column(
                                          children: [
                                            Text(
                                              'New Out-time',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            
                                            TextButton.icon(
                                              onPressed: _selectOutTime,
                                              icon: Icon(
                                                Icons.access_time,
                                                color: Colors.black,
                                              ),
                                              label: Text(
                                                _outTime.format(context),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      leaveData.leaveName ?? 'N/A',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (status.toLowerCase() == 'rejected' &&
                                        leaveData.rejectionReason != null)
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          'Reason: ${leaveData.rejectionReason}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: -48,
                                top: 20,
                                child: Container(
                                  height: 55,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          overflow: TextOverflow.visible,
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -48,
                                top: 90,
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
                                  ),
                                  child: Center(
                                    child: Text(
                                      leaveData.leaveType ?? 'N/A',
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
