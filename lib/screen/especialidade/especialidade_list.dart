import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/especialidade/especialidade_form.dart';
import 'package:farmasys/service/interface/i_service_lista_especialidade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EspecialidadeList extends StatelessWidget {
  static const String routeName = '/especialidade-list';

  const EspecialidadeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Especialidade>>(
        stream: context.read<IServiceEspecialidade>().streamAll(),
        showChild: (especialidades) {
          return especialidades != null && especialidades.isNotEmpty;
        },
        builder: (ctx, especialidades) {
          return EntityListView<Especialidade>(
            items: especialidades,
            childBuilder: (ctx, especialidade) {
              return Column(
                children: [
                  Text(
                    especialidade.nome,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: EspecialidadeForm.show,
            removeAction: ctx.read<IServiceEspecialidade>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EspecialidadeForm.show(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
