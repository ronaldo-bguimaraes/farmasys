import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/repository/cliente_firebase_repository.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/screen/alert/exclusion_confirmation.dart';
import 'package:farmasys/screen/cliente/cliente_add.dart';
import 'package:farmasys/screen/cliente/cliente_edit.dart';
import 'package:farmasys/service/cliente_service.dart';
import 'package:flutter/material.dart';

class ClienteList extends StatefulWidget {
  static const String routeName = '/cliente-list';

  const ClienteList({Key? key}) : super(key: key);

  @override
  State<ClienteList> createState() => _ClienteListState();
}

class _ClienteListState extends State<ClienteList> {
  late final IRepository<Cliente> _repository;
  late final ClienteService<Cliente> _service;

  @override
  void initState() {
    super.initState();
    _repository = ClienteFirebaseRepository();
    _service = ClienteService<Cliente>(_repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente'),
      ),
      body: StreamBuilder<List<Cliente>>(
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
                  var cliente = data[index];
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
                                  cliente.nome,
                                ),
                                subtitle: Text(
                                  cliente.telefone,
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
                                      await _service.delete(cliente);
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
                          builder: (context) => ClienteEdit(cliente: cliente),
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
          Navigator.of(context).pushNamed(ClienteAdd.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
