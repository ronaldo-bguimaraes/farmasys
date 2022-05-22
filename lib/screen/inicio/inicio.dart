import 'package:farmasys/dto/farmaceutico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _ReceitaHomeState();
}

class _ReceitaHomeState extends State<Inicio> {
  final List<String> _categorias = ['Vendas', 'Receitas'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Inicio'),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(children: [
          Consumer<Future<Farmaceutico?>>(
            builder: (context, value, child) {
              return Container();
            },
          ),
          Container(),
        ]),
      ),
      length: _categorias.length,
    );
  }
}
