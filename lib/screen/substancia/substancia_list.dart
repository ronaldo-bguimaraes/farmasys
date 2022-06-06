import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/screen/builder/future_snapshot_builder.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/screen/substancia/substancia_form.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/interface/i_service_substancia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubstanciaList extends StatefulWidget {
  static const String routeName = '/substancia-list';

  const SubstanciaList({Key? key}) : super(key: key);

  @override
  State<SubstanciaList> createState() => _SubstanciaListState();
}

class _SubstanciaListState extends State<SubstanciaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Substancia>>(
        stream: context.read<IServiceSubstancia>().streamAll(),
        isEmpty: (data) {
          return data == null || data.isEmpty;
        },
        builder: (context, substancia) {
          return CustomListView<Substancia>(
            data: substancia,
            childBuilder: (context, substancia) {
              final listaControle = substancia.listaControle;
              return Column(
                children: [
                  Text(substancia.nome, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text(
                    'Lista de controle: ${listaControle?.descricao}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dispensação Máxima: ${listaControle?.dispensacaoMaxima}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            onTapEdit: (context, substancia) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FutureSnapshotBuilder<List<ListaControle>>(
                      future: context.read<IServiceListaControle>().all(),
                      showChild: (listasControle) {
                        return listasControle == null;
                      },
                      builder: (context, listasControle) {
                        return SubstanciaForm(
                          title: 'Editar Substância',
                          substancia: substancia,
                          listasControle: listasControle,
                        );
                      },
                    );
                  },
                ),
              );
            },
            onAcceptDelete: (context, substancia) async {
              context.read<IServiceSubstancia>().remove(substancia).whenComplete(() {
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
                return FutureSnapshotBuilder<List<ListaControle>>(
                  future: context.read<IServiceListaControle>().all(),
                  showChild: (listasControle) {
                    return listasControle == null;
                  },
                  builder: (context, listasControle) {
                    return SubstanciaForm(
                      title: 'Cadastrar Substância',
                      substancia: Substancia(
                        nome: '',
                      ),
                      listasControle: listasControle,
                    );
                  },
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
