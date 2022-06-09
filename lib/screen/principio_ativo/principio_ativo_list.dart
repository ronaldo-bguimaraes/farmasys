import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/principio_ativo/principio_ativo_form.dart';
import 'package:farmasys/service/interface/i_service_principio_ativo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrincipioAtivoList extends StatefulWidget {
  static const String routeName = '/principio_ativo-list';

  const PrincipioAtivoList({Key? key}) : super(key: key);

  @override
  State<PrincipioAtivoList> createState() => _PrincipioAtivoListState();
}

class _PrincipioAtivoListState extends State<PrincipioAtivoList> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<PrincipioAtivo>>(
        stream: ctx.read<IServicePrincipioAtivo>().streamAll(),
        showChild: (principiosAtivos) {
          return principiosAtivos != null && principiosAtivos.isNotEmpty;
        },
        builder: (ctx, principiosAtivos) {
          return EntityListView<PrincipioAtivo>(
            items: principiosAtivos,
            childBuilder: (ctx, principioAtivo) {
              final listaControle = principioAtivo.listaControle;
              return Column(
                children: [
                  Text(
                    principioAtivo.nome,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lista de controle: ${listaControle != null ? listaControle.nome : "não possui"}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Dispensação máxima: ${listaControle != null ? "suficiente para ${listaControle.duracaoTratamento} dias" : "indefinida"}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: PrincipioAtivoForm.show,
            removeAction: ctx.read<IServicePrincipioAtivo>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PrincipioAtivoForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
