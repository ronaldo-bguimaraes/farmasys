import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/cliente/cliente_list.dart';
import 'package:farmasys/screen/dashboard/dashboard_item.dart';
import 'package:farmasys/screen/farmaceutico/farmaceutico_sign_in.dart';
import 'package:farmasys/screen/medicamento/medicamento_inicio.dart';
import 'package:farmasys/screen/medico/medico_inicio.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_inicio.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      assetName: './assets/images/medico.png',
      event: (context) {
        Navigator.of(context).pushNamed(MedicoInicio.routeName);
      },
    ),
    DashboardItem(
      title: 'Clientes',
      subTitle: 'Lista de clientes',
      assetName: './assets/images/cliente.png',
      event: (context) {
        Navigator.of(context).pushNamed(ClienteList.routeName);
      },
    ),
    DashboardItem(
      title: 'Tipos',
      subTitle: 'Tipos de receita, notificação',
      assetName: './assets/images/receita.png',
      event: (context) {
        Navigator.of(context).pushNamed(TiposInicio.routeName);
      },
    ),
    DashboardItem(
      title: 'Medicamentos',
      subTitle: 'Listas de medicamentos, substâncias e controle',
      assetName: './assets/images/medicamento.png',
      event: (context) {
        Navigator.of(context).pushNamed(MedicamentoInicio.routeName);
      },
    ),
    DashboardItem(
      title: 'Sair',
      subTitle: 'Fazer logout',
      assetName: './assets/images/sair.png',
      event: (context) async {
        try {
          await context.read<IServiceFarmaceutico>().signOut();
          Navigator.of(context).pushNamedAndRemoveUntil(
            FarmaceuticoSignIn.routeName,
            (_) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logout realizado com sucesso!'),
              duration: Duration(seconds: 1),
            ),
          );
        }
        //
        on ExceptionMessage catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message),
              duration: const Duration(seconds: 1),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de Opções'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: _list.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 225,
            childAspectRatio: 1,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(_list[index].assetName),
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _list[index].title,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        _list[index].subTitle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              onTap: () {
                _list[index].event(context);
              },
            );
          },
        ),
      ),
    );
  }
}
