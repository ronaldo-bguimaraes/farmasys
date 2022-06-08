import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/cliente/cliente_list.dart';
import 'package:farmasys/screen/dashboard/dashboard_item.dart';
import 'package:farmasys/screen/farmaceutico/farmaceutico_sign_in.dart';
import 'package:farmasys/screen/helper/empty_pedicate.dart';
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
      event: (ctx) {
        Navigator.of(ctx).pushNamed(MedicoInicio.routeName);
      },
    ),
    DashboardItem(
      title: 'Clientes',
      subTitle: 'Lista de clientes',
      assetName: './assets/images/cliente.png',
      event: (ctx) {
        Navigator.of(ctx).pushNamed(ClienteList.routeName);
      },
    ),
    DashboardItem(
      title: 'Tipos',
      subTitle: 'Tipos de receita, notificação',
      assetName: './assets/images/receita.png',
      event: (ctx) {
        Navigator.of(ctx).pushNamed(TiposInicio.routeName);
      },
    ),
    DashboardItem(
      title: 'Medicamentos',
      subTitle: 'Listas de medicamentos, princípios ativos e controle',
      assetName: './assets/images/medicamento.png',
      event: (ctx) {
        Navigator.of(ctx).pushNamed(MedicamentoInicio.routeName);
      },
    ),
    DashboardItem(
      title: 'Sair',
      subTitle: 'Fazer logout',
      assetName: './assets/images/sair.png',
      event: (ctx) async {
        try {
          await ctx.read<IServiceFarmaceutico>().signOut();
          Navigator.of(ctx).pushNamedAndRemoveUntil(FarmaceuticoSignIn.routeName, emptyPredicate);
          ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(
              content: Text('Logout realizado com sucesso.'),
              duration: Duration(milliseconds: 1200),
            ),
          );
        }
        //
        on ExceptionMessage catch (error) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text('Erro: ${error.message}'),
              duration: const Duration(milliseconds: 1200),
            ),
          );
          Navigator.of(ctx).pop();
        }
      },
    ),
  ];

  @override
  Widget build(BuildContext ctx) {
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
          itemBuilder: (BuildContext ctx, int index) {
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
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              onTap: () {
                _list[index].event(ctx);
              },
            );
          },
        ),
      ),
    );
  }
}
