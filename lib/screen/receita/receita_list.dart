import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/receita/receita_form.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReceitaList extends StatefulWidget {
  const ReceitaList({Key? key}) : super(key: key);

  @override
  State<ReceitaList> createState() => _ReceitaListState();
}

class _ReceitaListState extends State<ReceitaList> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Receita>>(
        stream: ctx.read<IServiceReceita>().streamAll(),
        showChild: (receitas) {
          return receitas != null && receitas.isNotEmpty;
        },
        builder: (ctx, receitas) {
          return EntityListView<Receita>(
            items: receitas,
            childBuilder: (ctx, receita) {
              return Column(
                children: [],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: ReceitaForm.show,
            removeAction: ctx.read<IServiceReceita>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ReceitaForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
