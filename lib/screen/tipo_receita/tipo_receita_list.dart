import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_form.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoReceitaList extends StatefulWidget {
  static const String routeName = '/tipo_receita-list';

  const TipoReceitaList({Key? key}) : super(key: key);

  @override
  State<TipoReceitaList> createState() => _TipoReceitaListState();
}

class _TipoReceitaListState extends State<TipoReceitaList> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<TipoReceita>>(
        stream: ctx.read<IServiceTipoReceita>().streamAll(),
        showChild: (tiposReceita) {
          return tiposReceita != null && tiposReceita.isNotEmpty;
        },
        builder: (ctx, tipoReceitas) {
          return EntityListView<TipoReceita>(
            items: tipoReceitas,
            childBuilder: (ctx, tipoReceita) {
              return Column(
                children: [
                  Text(
                    tipoReceita.nome,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: TipoReceitaForm.show,
            removeAction: ctx.read<IServiceTipoReceita>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TipoReceitaForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
