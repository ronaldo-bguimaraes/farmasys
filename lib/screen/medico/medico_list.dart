import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/repository/medico_firebase_repository.dart';
import 'package:farmasys/screen/alert/exclusion_confirmation.dart';
import 'package:farmasys/screen/medico/medico_add.dart';
import 'package:farmasys/screen/medico/medico_edit.dart';
import 'package:farmasys/service/medico_service.dart';
import 'package:flutter/material.dart';

class MedicoList extends StatefulWidget {
  static const String routeName = '/medico-list';

  const MedicoList({Key? key}) : super(key: key);

  @override
  State<MedicoList> createState() => _MedicoListState();
}

class _MedicoListState extends State<MedicoList> {
  late final IRepository<Medico> _repository;
  late final MedicoService<Medico> _service;

  @override
  void initState() {
    super.initState();
    _repository = MedicoFirebaseRepository();
    _service = MedicoService<Medico>(_repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Médicos'),
      ),
      body: StreamBuilder<List<Medico>>(
        stream: _service.all(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //
          else if (data == null || data.isEmpty) {
            return const Center(
              child: Text("Não há dados disponíveis"),
            );
          }
          //
          else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var medico = data[index];
                  return GestureDetector(
                    child: Card(
                      margin: const EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListTile(
                                title: Text(
                                  '${medico.nome} (CRM: ${medico.crm.codigo}-${medico.crm.uf})',
                                ),
                                subtitle: Text(
                                  medico.especialidade,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 0,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showExclusionConfirmation(
                                    context: context,
                                    onAccept: (close) async {
                                      await _service.delete(medico);
                                      close();
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MedicoEdit(medico: medico),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(snapshot.connectionState.name)
                    ],
                  );
                },
                itemCount: data.length,
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(MedicoAdd.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
