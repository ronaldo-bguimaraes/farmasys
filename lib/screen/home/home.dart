import 'package:farmasys/screen/dashboard/dashboard.dart';
import 'package:farmasys/screen/helper/empty_pedicate.dart';
import 'package:farmasys/screen/home/home_inicio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

  static Future<void> show(BuildContext ctx) async {
    return await Navigator.of(ctx).pushAndRemoveUntil<void>(
      MaterialPageRoute(
        builder: (ctx) {
          return const Home();
        },
      ),
      emptyPredicate,
    );
  }
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = const [
      HomeInicio(),
      Dashboard(),
    ];
  }

  @override
  Widget build(BuildContext ctx) {
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
