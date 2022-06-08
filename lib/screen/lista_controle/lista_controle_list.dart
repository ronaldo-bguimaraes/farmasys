import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
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
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<ListaControle>>(
        stream: ctx.read<IServiceListaControle>().streamAll(),
        showChild: (listasControle) {
          return listasControle != null && listasControle.isNotEmpty;
        },
        builder: (ctx, listasControle) {
          return EntityListView<ListaControle>(
            items: listasControle,
            childBuilder: (ctx, listaControle) {
              final tipoReceita = listaControle.tipoReceita;
              final tipoNotificacao = listaControle.tipoNotificacao;
              return Column(
                children: [
                  Text(
                    '${listaControle.nome} - ${tipoNotificacao != null ? "Notificação ${tipoNotificacao.nome}" : "Sem notificação"}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tipo de receita: ${tipoReceita?.nome}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Duração de tratamento: ${listaControle.duracaoTratamento} dias',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Prazo de validade da receita: ${listaControle.prazo} dias',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: ListaControleForm.show,
            removeAction: ctx.read<IServiceListaControle>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ListaControleForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
