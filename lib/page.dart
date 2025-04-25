import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:inventory_app/login1.dart';
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
  bool isSearching = false;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load user info from Hive
    getUserInfo();
  }

  void getUserInfo() async {
    final authBox = Hive.box('authBox');
    final email = authBox.get('userEmail', defaultValue: "User");
    final role = authBox.get('userRole', defaultValue: "");

    setState(() {
      userName =
          email.toString().split('@')[0]; // Use the part before @ as name
      userRole = role;
    });
  }

  void logout() {
    // Set the user as logged out
    final authBox = Hive.box('authBox');
    authBox.put('isLoggedIn', false);

    // Navigate to login page
    Get.offAll(() => const LoginPage());
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0:Home', style: optionStyle),
    Text('Index 1:Business', style: optionStyle),
    Text('Index 2:School', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of items for search suggestions
  final List<String> _searchItems = [
    '1) First Task',
    '2) Second Task',
    '3) Third Task',
    '4) Fourth Task',
    '5) Fifth Task',
  ];

  @override
  Widget build(BuildContext context) {
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
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            ' Products',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.15,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.star,
                  label: 'star',
                  pageToNavigate: StarPage(),
                ),
                SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.star,
                  label: 'star',
                  pageToNavigate: StarPage(),
                ),
                SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.contact_emergency,
                  label: 'contact',
                  pageToNavigate: StarPage(),
                ),
                SizedBox(width: 10),
                ReusableCircleCard(
                  icon: Icons.stacked_line_chart_rounded,
                  label: 'chart1',
                  pageToNavigate: StarPage(),
                ),
                SizedBox(width: 10),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Search tasks...',
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged: (value) {
                      setState(() {
                        isSearching = value.isNotEmpty;
                      });
                    },
                    onSubmitted: (value) {
                      if (_searchItems.any(
                        (item) =>
                            item.toLowerCase().contains(value.toLowerCase()),
                      )) {
                        setState(() {
                          // Keep only the matched item selected
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: $value')),
                          );
                          isSearching = false;
                        });
                      }
                      // Hide dropdown after submission
                      // setState(() {
                      //   isSearching = false;
                      // });
                    },
                  ),
                ),

                // Dropdown Menu (only visible when searching)
                if (isSearching)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    constraints: const BoxConstraints(maxHeight: 200),
                    width: double.infinity,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children:
                          _searchItems
                              .where(
                                (item) => item.toLowerCase().contains(
                                  controller.text.toLowerCase(),
                                ),
                              )
                              .map(
                                (item) => ListTile(
                                  title: Text(item),
                                  // leading: const Icon(Icons.task),
                                  onTap: () {
                                    setState(() {
                                      controller.text = item;
                                      isSearching = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Selected: $item'),
                                      ),
                                    );
                                  },
                                ),
                              )
                              .toList(),
                    ),
                  ),
              ],
            ),
          ),

          // Display selected item if any
          if (controller.text.isNotEmpty && !isSearching)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected: ${controller.text}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

          Text(
            "To Do List",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),

          Flexible(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: Text(
                  //   "To Do List",
                  //   style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('1) First Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('2) Second Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('3) Third Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(title: Text('4) Fourth Task')),
                ),
              ],
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
