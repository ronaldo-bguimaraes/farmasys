import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/screen/receita.dart';
import 'package:flutter/material.dart';

class HomeInicio extends StatefulWidget {
  final Farmaceutico farmaceutico;

  const HomeInicio({
    Key? key,
    required this.farmaceutico,
  }) : super(key: key);

  @override
  State<HomeInicio> createState() => _HomeInicioState();
}

class _HomeInicioState extends State<HomeInicio> {
  final List<String> _categorias = ['Receitas', 'Vendas'];

  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.farmaceutico.nome),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ReceitaAdd.show(ctx);
                },
                child: const Text('Validar Receita'),
              ),
            ),
            Container(),
          ],
        ),
      ),
      length: _categorias.length,
    );
  }
}
