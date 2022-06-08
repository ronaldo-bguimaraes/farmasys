import 'package:farmasys/screen/receita/receita_list.dart';
import 'package:farmasys/service/interface/i_service_authentication_farmaceutico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeInicio extends StatefulWidget {
  const HomeInicio({Key? key}) : super(key: key);

  @override
  State<HomeInicio> createState() => _HomeInicioState();
}

class _HomeInicioState extends State<HomeInicio> {
  final List<String> _categorias = ['Receitas'];

  @override
  Widget build(BuildContext ctx) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: Text(ctx.read<IServiceAuthenticationFarmaceutico>().currentUser?.nome ?? ''),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: [
            ReceitaList(),
          ],
        ),
      ),
      length: _categorias.length,
    );
  }
}
