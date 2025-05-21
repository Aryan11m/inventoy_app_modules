import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_app/main.dart';

final List<String> years = <String>['2025', '2024', '2023'];
final List<String> months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];
final List<String> approvals = <String>['Pending', 'Approved', 'Rejected'];

class Approval extends StatefulWidget {
  const Approval({super.key});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  String? dropdownValue;
  String? dropdownValue1;
  String? dropdownValue2;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.rectangle,
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 28),
                  child: DropdownButton<String>(
                    hint: Text(
                      DateFormat.y().format(DateTime.now()),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: dropdownValue,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),

                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
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
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.rectangle,
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 24),
                  child: DropdownButton<String>(
                    hint: Text(
                      DateFormat.LLLL().format(DateTime.now()),

                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: dropdownValue1,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),

                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue1 = value!;
                      });
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
            const SizedBox(height: 20),

            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    shape: BoxShape.rectangle,
                    border: Border.all(),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  child: DropdownButton<String>(
                    hint: Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: dropdownValue2,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),

                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue2 = value!;
                      });
                    },
                    items:
                        approvals.map<DropdownMenuItem<String>>((String value) {
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
          ],
        ),
      ),
    );
  }
}
