import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicoSelect extends StatefulWidget {
  const MedicoSelect({Key? key}) : super(key: key);

  @override
  State<MedicoSelect> createState() => _MedicoSelectState();

  static Future<Medico?> show(BuildContext ctx) async {
    return await Navigator.of(ctx).push<Medico?>(
      MaterialPageRoute(
        builder: (ctx) {
          return const MedicoSelect();
        },
      ),
    );
  }
}

class _MedicoSelectState extends State<MedicoSelect> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o médico'),
      ),
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
                  Text('Área de especialidade: ${medico.especialidade.nome}'),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: (ctx, medico) {
              Navigator.of(ctx).pop(medico);
            },
            removeAction: ctx.read<IServiceMedico>().remove,
          );
        },
      ),
    );
  }
}
