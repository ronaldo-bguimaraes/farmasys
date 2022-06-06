import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
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
    return Consumer<IServiceEspecialidade>(
      builder: (context, serviceEspecialidade, _) {
        return Scaffold(
          body: StreamSnapshotBuilder<List<Especialidade>>(
            stream: serviceEspecialidade.streamAll(),
            isEmpty: (especialidade) {
              return especialidade == null || especialidade.isEmpty;
            },
            builder: (context, especialidade) {
              return CustomListView<Especialidade>(
                data: especialidade,
                childBuilder: (context, especialidade) {
                  return Text(
                    especialidade.descricao,
                  );
                },
                onTapEdit: (context, especialidade) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return EspecialidadeForm(
                          title: 'Editar Especialidade',
                          especialidade: especialidade,
                        );
                      },
                    ),
                  );
                },
                onAcceptDelete: (context, especialidade) async {
                  serviceEspecialidade.remove(especialidade).whenComplete(() {
                    Navigator.of(context).pop();
                  });
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Cadastrar Especialidade'),
                    content: EspecialidadeForm(
                      title: 'Editar Especialidade',
                      especialidade: Especialidade(descricao: ''),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
