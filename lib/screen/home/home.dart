import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/screen/builder/future_snapshot_builder.dart';
import 'package:farmasys/screen/dashboard/dashboard.dart';
import 'package:farmasys/screen/helper/empty_pedicate.dart';
import 'package:farmasys/screen/home/home_inicio.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final Farmaceutico farmaceutico;

  const Home({Key? key, required this.farmaceutico}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();

  static void show(BuildContext ctx) {
    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) {
          return FutureSnapshotBuilder<Farmaceutico>(
            future: ctx.read<IServiceFarmaceutico>().getCurrentUser(),
            showChild: (farmaceutico) {
              return farmaceutico != null;
            },
            builder: (ctx, farmaceutico) {
              return Home(
                farmaceutico: farmaceutico,
              );
            },
          );
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
    _pages = [
      HomeInicio(
        farmaceutico: widget.farmaceutico,
      ),
      const Dashboard(),
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
