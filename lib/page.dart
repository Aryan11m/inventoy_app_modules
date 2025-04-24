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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello $userName ($userRole)',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showSearch(context: context, delegate: MySearchDelegate());
        //     },
        //     icon: const Icon(Icons.search),
        //   ),
        // ],
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
          Flexible(
            child: ListView(
              scrollDirection: Axis.vertical,

              children: [
                IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: MySearchDelegate());
                  },
                  icon: const Icon(Icons.search),
                  iconSize: 35,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "To Do List",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                  ),
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

          // SizedBox(
          //   height: height * 0.65,
          //   child: ListView(
          //     scrollDirection: Axis.vertical,
          //     children: [
          //       ReusableCircleCard(
          //         icon: Icons.shopping_cart,
          //         label: 'Product',
          //         pageToNavigate: StarPage(),
          //       ),
          //       SizedBox(width: 10),
          //       ReusableCircleCard(
          //         icon: Icons.star,
          //         label: 'star',
          //         pageToNavigate: StarPage(),
          //       ),
          //       SizedBox(width: 10),
          //       ReusableCircleCard(
          //         icon: Icons.star,
          //         label: 'star',
          //         pageToNavigate: StarPage(),
          //       ),
          //       SizedBox(width: 10),
          //       ReusableCircleCard(
          //         icon: Icons.contact_emergency,
          //         label: 'contact',
          //         pageToNavigate: StarPage(),
          //       ),
          //       SizedBox(width: 10),
          //       ReusableCircleCard(
          //         icon: Icons.stacked_line_chart_rounded,
          //         label: 'chart1',
          //         pageToNavigate: StarPage(),
          //       ),
          //       SizedBox(width: 10),
          //       ReusableCircleCard(
          //         icon: Icons.stacked_line_chart_rounded,
          //         label: 'chart2',
          //         pageToNavigate: StarPage(),
          //       ),
          //     ],
          //   ),
          // ),
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

// class MySearchDelegate extends SearchDelegate {
//   List<String> searchResults = [
//     'Product 1',
//     'Product 2',
//     'Product 3',
//     'Product 4',
//     'Product 5',
//   ];
//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//     onPressed: () => close(context, null),
//     icon: const Icon(Icons.arrow_back),
//   );

//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//     IconButton(
//       icon: const Icon(Icons.clear),
//       onPressed: () {
//         if (query.isEmpty) {
//           close(context, null);
//         } else {
//           query = '';
//         }
//       },
//     ),
//   ];

//   @override
//   Widget buildResults(BuildContext context) => Center(
//     child: Text(
//       query,
//       style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
//     ),
//   );

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestions =
//         searchResults.where((searchResult) {
//           final result = searchResult.toLowerCase();
//           final input = query.toLowerCase();

//           return result.contains(input);
//         }).toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final suggestion = suggestions[index];

//         return ListTile(
//           title: Text(suggestion),
//           onTap: () {
//             query = suggestion;

//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    '1) First Task',
    '2) Second Task',
    '3) Third Task',
    '4) Fourth Task',
    '5) Fifth Task',
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    ),
  ];

  @override
  Widget buildResults(BuildContext context) {
    // Check if the query exactly matches any result
    bool exactMatch = searchResults.any(
      (result) => result.toLowerCase() == query.toLowerCase(),
    );

    // If there's no exact match, show "No results found"
    if (!exactMatch) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No results found for "$query"',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try searching from available suggestions',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // If we have an exact match, show the result
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            query,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Product found!',
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions =
        searchResults.where((searchResult) {
          final result = searchResult.toLowerCase();
          final input = query.toLowerCase();
          return result.contains(input);
        }).toList();

    // Show "No suggestions found" when there are no matching suggestions
    if (suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No suggestions found for "$query"',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Show suggestions when we have matches
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          leading: const Icon(Icons.search),
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  // Override this method to handle search submission
  @override
  void showResults(BuildContext context) {
    // Check if the exact query matches any of our items before showing results
    bool hasMatch = searchResults.any(
      (result) => result.toLowerCase() == query.toLowerCase(),
    );

    // Only allow proceeding to results if there's an exact match
    if (hasMatch) {
      super.showResults(context);
    } else {
      // If not an exact match, we still show results screen but it will
      // display "No results found" as implemented in buildResults
      super.showResults(context);
    }
  }
}
