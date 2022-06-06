import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/screen/lista_controle/lista_controle_form.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaControleList extends StatefulWidget {
  static const String routeName = '/lista-controle-list';

  const ListaControleList({Key? key}) : super(key: key);

  @override
  State<ListaControleList> createState() => _ListaControleListState();
}

class _ListaControleListState extends State<ListaControleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<ListaControle>>(
        stream: context.read<IServiceListaControle>().streamAll(),
        isEmpty: (data) {
          return data == null || data.isEmpty;
        },
        builder: (context, listaControle) {
          return CustomListView<ListaControle>(
            data: listaControle,
            childBuilder: (context, listaControle) {
              return Column(
                children: [
                  Text(
                    listaControle.descricao,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dispensação máxima: ${listaControle.dispensacaoMaxima}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            onTapEdit: (context, data) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ListaControleForm(
                      title: 'Editar lista de controle',
                      listaControle: data,
                    );
                  },
                ),
              );
            },
            onAcceptDelete: (context, listaControle) async {
              context.read<IServiceListaControle>().remove(listaControle).whenComplete(() {
                Navigator.of(context).pop();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ListaControleForm(
                  title: 'Editar lista de controle',
                  listaControle: ListaControle(
                    descricao: '',
                    dispensacaoMaxima: 0,
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
