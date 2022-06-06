import 'package:flutter/material.dart';

class HomeInicio extends StatefulWidget {
  const HomeInicio({Key? key}) : super(key: key);

  @override
  State<HomeInicio> createState() => _HomeInicioState();
}

class _HomeInicioState extends State<HomeInicio> {
  final List<String> _categorias = ['Vendas', 'Receitas'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            Container(),
          ],
        ),
      ),
      length: _categorias.length,
    );
  }
}
