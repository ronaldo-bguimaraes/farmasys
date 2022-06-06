import 'package:farmasys/dto/crm.dart';
import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/screen/builder/future_snapshot_builder.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/screen/medico/medico_form.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/service/interface/i_service_lista_especialidade.dart';
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
  Widget build(BuildContext context) {
    return Consumer<IServiceMedico>(
      builder: (context, serviceMedico, _) {
        return Scaffold(
          body: StreamSnapshotBuilder<List<Medico>>(
            stream: serviceMedico.streamAll(),
            isEmpty: (medicos) {
              return medicos == null || medicos.isEmpty;
            },
            builder: (context, medicos) {
              return CustomListView<Medico>(
                data: medicos,
                childBuilder: (context, medico) {
                  return Padding(
                    child: ListTile(
                      title: Text(
                        medico.nome,
                      ),
                      subtitle: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text('CRM: ${medico.crm.codigo}-${medico.crm.uf}'),
                          const SizedBox(height: 10),
                          Text('Área de especialidade: ${medico.especialidade}'),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  );
                },
                onTapEdit: (context, medico) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return FutureSnapshotBuilder<List<Especialidade>>(
                          future: context.read<IServiceEspecialidade>().all(),
                          showChild: (especialidades) {
                            return especialidades == null;
                          },
                          builder: (context, especialidades) {
                            return MedicoForm(
                              title: 'Editar Médico',
                              medico: medico,
                              especialidades: especialidades,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                onAcceptDelete: (context, medico) {
                  context.read<IServiceMedico>().remove(medico).whenComplete(() {
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
                    return FutureSnapshotBuilder<List<Especialidade>>(
                      future: context.read<IServiceEspecialidade>().all(),
                      showChild: (especialidades) {
                        return especialidades == null;
                      },
                      builder: (context, especialidades) {
                        return MedicoForm(
                          title: 'Editar Médico',
                          medico: Medico(
                            nome: '',
                            telefone: '',
                            crm: CRM(codigo: '', uf: ''),
                          ),
                          especialidades: especialidades,
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
      },
    );
  }
}
