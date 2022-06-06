import 'package:farmasys/screen/especialidade/especialidade_list.dart';
import 'package:farmasys/screen/medico/medico_list.dart';
import 'package:flutter/material.dart';

class MedicoInicio extends StatefulWidget {
  static const String routeName = '/medico-inicio';

  const MedicoInicio({Key? key}) : super(key: key);

  @override
  State<MedicoInicio> createState() => _MedicoInicioState();
}

class _MedicoInicioState extends State<MedicoInicio> {
  final List<String> _categorias = [
    'Medicos',
    'Especialidades',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Medico Inicio'),
          bottom: TabBar(
            tabs: _categorias.map((e) => Tab(text: e)).toList(),
            isScrollable: true,
          ),
        ),
        body: const TabBarView(
          children: [
            MedicoList(),
            EspecialidadeList(),
          ],
        ),
      ),
      length: _categorias.length,
    );
  }
}
