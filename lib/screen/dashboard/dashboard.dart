import 'package:farmasys/screen/cliente/cliente_list.dart';
import 'package:farmasys/screen/dashboard/dashboard_item.dart';
import 'package:farmasys/screen/medicamento/medicamento_list.dart';
import 'package:farmasys/screen/medico/medico_list.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<DashboardItem> _list = [
    DashboardItem(
      title: 'Medicos',
      subTitle: 'Lista de Médicos',
      image: './assets/images/medico.png',
      event: (context) {
        Navigator.of(context).pushNamed(MedicoList.routeName);
      },
    ),
    DashboardItem(
      title: 'Clientes',
      subTitle: 'Lista de Clientes',
      image: './assets/images/cliente.png',
      event: (context) {
        Navigator.of(context).pushNamed(ClienteList.routeName);
      },
    ),
    DashboardItem(
      title: 'Medicamentos',
      subTitle: 'Lista de Medicamentos',
      image: './assets/images/medicamento.png',
      event: (context) {
        Navigator.of(context).pushNamed(MedicamentoList.routeName);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: _list.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (BuildContext context, int index) {
            var item = _list[index];
            return GestureDetector(
              child: Card(
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(item.image),
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        item.subTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              onTap: () {
                item.event(context);
              },
            );
          },
        ),
      ),
    );
  }
}
