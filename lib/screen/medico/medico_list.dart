import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/medico/medico_form.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicoList extends StatefulWidget {
  static const String routeName = '/medico-list';

  const MedicoList({Key? key}) : super(key: key);

  @override
  State<MedicoList> createState() => _MedicoListState();
}

class _MedicoListState extends State<MedicoList> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Medico>>(
        stream: ctx.read<IServiceMedico>().streamAll(),
        showChild: (medicos) {
          return medicos != null && medicos.isNotEmpty;
        },
        builder: (ctx, medicos) {
          return EntityListView<Medico>(
            items: medicos,
            childBuilder: (ctx, medico) {
              return Column(
                children: [
                  Text(
                    medico.nome,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text('CRM/UF: ${medico.crm.codigo}/${medico.crm.uf}'),
                  const SizedBox(height: 10),
                  Text('Área de especialidade: ${medico.especialidade?.nome}'),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: MedicoForm.show,
            removeAction: ctx.read<IServiceMedico>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MedicoForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
