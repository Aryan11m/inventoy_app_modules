import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/QRCode/company_code.dart';
import 'package:inventory_app/Subs/subscription.dart';
import 'package:inventory_app/main.dart';
import 'package:inventory_app/cards.dart';
import 'package:inventory_app/star.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SearchController controller = SearchController();
  String userName = "";
  String userRole = "";
  bool status1 = false;
  // bool isSearching = false;

  int _selectedIndex = 0;

  final List<String> _tasks = [
    '1) First Task',
    '2) Second Task',
    '3) Third Task',
    '4) Fourth Task',
    '5) Fifth Task',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    final authBox = Hive.box('authBox');
    // Make sure to clear any cached values
    await authBox.flush();

    setState(() {
      status1 = authBox.get('status', defaultValue: false);
      userName =
          authBox
              .get('userEmail', defaultValue: "User")
              .toString()
              .split('@')[0];
      userRole = authBox.get('userRole', defaultValue: "");
    });

    print("In getUserInfo, status1 is: $status1"); // Debug print
  }

  bool checkSubscriptionStatus() {
    final authBox = Hive.box('authBox');
    bool currentStatus = authBox.get('status', defaultValue: false);
    print("checkSubscriptionStatus returns: $currentStatus"); // Debug print
    return currentStatus;
  }

  void logout() {
    // Set the user as logged out
    final authBox = Hive.box('authBox');
    authBox.put('isLoggedIn', false);
    setState(() {});

    // Navigate to login page
    Get.offAll(() => const CompanyCode());
  }

  // static const TextStyle optionStyle = TextStyle(
  //   fontSize: 30,
  //   fontWeight: FontWeight.bold,
  // );

  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Index 0:Home', style: optionStyle),
  //   Text('Index 1:Business', style: optionStyle),
  //   Text('Index 2:School', style: optionStyle),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Force refresh status at build time
    status1 = checkSubscriptionStatus();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello $userName ($userRole)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Always check fresh status
                bool currentStatus = checkSubscriptionStatus();

                if (currentStatus) {
                  Scaffold.of(context).openDrawer();
                } else {
                  Get.to(() => Subscription1())?.then((_) {
                    // Force UI update when returning
                    setState(() {
                      status1 = checkSubscriptionStatus();
                    });
                  });
                }
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              bool currentStatus = checkSubscriptionStatus();
              if (!currentStatus) {
                Get.to(() => Subscription1())?.then((_) {
                  // Update status1 when returning from subscription page
                  final authBox = Hive.box('authBox');
                  setState(() {
                    status1 = authBox.get('status', defaultValue: false);
                  });
                });
              } else {
                Get.to(StarPage());
              }
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: const Icon(Icons.play_arrow),
      //   label: const Text('Show Snackbar'),
      // ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            ' Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.19,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              children: [
                // SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.star,
                  label: 'star',
                  pageToNavigate: StarPage(),
                ),
                // SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.star,
                  label: 'star',
                  pageToNavigate: StarPage(),
                ),
                // SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.contact_emergency,
                  label: 'contact',
                  pageToNavigate: StarPage(),
                ),
                // SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.stacked_line_chart_rounded,
                  label: 'chart1',
                  pageToNavigate: StarPage(),
                ),
                // SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.stacked_line_chart_rounded,
                  label: 'chart2',
                  pageToNavigate: StarPage(),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Custom Search with Dropdown
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(255, 153, 22, 22),
                ),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  setState(() {
                    // This will trigger a rebuild and filter the list
                  });
                },
              ),
            ),
          ),
          // Display selected item if any
          // if (controller.text.isNotEmpty)
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       'Selected: ${controller.text}',
          //       style: const TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //   ),
          const SizedBox(height: 20),
          Flexible(
            // height: height * 0.54,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount:
                  _tasks
                      .where(
                        (task) => task.toLowerCase().contains(
                          controller.text.toLowerCase(),
                        ),
                      )
                      .length,
              itemBuilder: (context, index) {
                final filteredTasks =
                    _tasks
                        .where(
                          (task) => task.toLowerCase().contains(
                            controller.text.toLowerCase(),
                          ),
                        )
                        .toList();
                final task = filteredTasks[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 117, 221, 157),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 117, 221, 157),
                          offset: const Offset(5.0, 5.0), //Offset
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: ListTile(
                      title: Text(task),
                      onTap: () {
                        print("task list which i tapped $task");
                        // controller.text = filteredTasks[index];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.amber),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, $userName',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('Role: $userRole'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Get.back();
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Get.back();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.grey.shade600,
            gap: 8,
            onTabChange: (index) {
              print(index);
              if (index == 0) {
                logout();
              }
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(icon: Icons.logout, text: 'Logout'),
              GButton(icon: Icons.favorite_border, text: 'Likes'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.settings, text: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}
