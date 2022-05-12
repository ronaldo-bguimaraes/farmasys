import 'package:farmasys/screen/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 1;

  final List<Widget> _pages = [
    Container(),
    const Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _selectedPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: "Menu",
          ),
        ],
        currentIndex: _selectedPage,
        onTap: _onTapped,
      ),
    );
  }

  _onTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }
}
