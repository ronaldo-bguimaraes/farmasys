import 'package:farmasys/screen/lista_controle/lista_controle_list.dart';
import 'package:farmasys/screen/medicamento/medicamento_list.dart';
import 'package:farmasys/screen/substancia/substancia_list.dart';
import 'package:flutter/material.dart';

class MedicamentoInicio extends StatefulWidget {
  static const String routeName = '/medicamento-inicio';

  const MedicamentoInicio({Key? key}) : super(key: key);

  @override
  State<MedicamentoInicio> createState() => _MedicamentoInicioState();
}

class _MedicamentoInicioState extends State<MedicamentoInicio> {
  final List<String> _categorias = [
    'Medicamentos',
    'Substâncias',
    'Listas de Controle',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medicamentos'),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: [
            MedicamentoList(),
            SubstanciaList(),
            ListaControleList(),
          ],
        ),
      ),
      length: _categorias.length,
    );
  }
}
