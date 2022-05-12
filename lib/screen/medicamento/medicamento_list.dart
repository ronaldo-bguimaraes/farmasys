import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/repository/medicamento_firebase_repository.dart';
import 'package:farmasys/screen/alert/exclusion_confirmation.dart';
import 'package:farmasys/screen/medicamento/medicamento_add.dart';
import 'package:farmasys/screen/medicamento/medicamento_edit.dart';
import 'package:farmasys/service/medicamento_service.dart';
import 'package:flutter/material.dart';

class MedicamentoList extends StatefulWidget {
  static const String routeName = '/medicamento-list';

  const MedicamentoList({Key? key}) : super(key: key);

  @override
  State<MedicamentoList> createState() => _MedicamentoListState();
}

class _MedicamentoListState extends State<MedicamentoList> {
  late final IRepository<Medicamento> _repository;
  late final MedicamentoService<Medicamento> _service;

  @override
  void initState() {
    super.initState();
    _repository = MedicamentoFirebaseRepository();
    _service = MedicamentoService<Medicamento>(_repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamento'),
      ),
      body: StreamBuilder<List<Medicamento>>(
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
                  var medicamento = data[index];
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
                                  '${medicamento.nome} ${medicamento.miligramas}mg ${medicamento.controlado ? '(Controlado)' : ''}',
                                ),
                                subtitle: Text(
                                  'Quantidade Disponível: ${medicamento.quantidade} unidades',
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
                                      await _service.delete(medicamento);
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
                          builder: (context) =>
                              MedicamentoEdit(medicamento: medicamento),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
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
          Navigator.of(context).pushNamed(MedicamentoAdd.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
