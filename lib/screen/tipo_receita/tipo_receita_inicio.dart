import 'package:farmasys/screen/tipo_notificacao/tipo_notificacao_list.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_list.dart';
import 'package:flutter/material.dart';

class TiposInicio extends StatefulWidget {
  static const String routeName = '/tipos-inicio';

  const TiposInicio({Key? key}) : super(key: key);

  @override
  State<TiposInicio> createState() => _TiposInicioState();
}

class _TiposInicioState extends State<TiposInicio> {
  final List<String> _categorias = [
    'Tipos de receita',
    'Tipos de notificação',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tipos de receita'),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: [
            TipoReceitaList(),
            TipoNotificacaoList(),
          ],
        ),
      ),
      length: _categorias.length,
    );
  }
}
