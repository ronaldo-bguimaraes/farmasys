import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/screen/cliente/cliente_form.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClienteList extends StatefulWidget {
  static const String routeName = '/cliente-list';

  const ClienteList({Key? key}) : super(key: key);

  @override
  State<ClienteList> createState() => _ClienteListState();
}

class _ClienteListState extends State<ClienteList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IServiceCliente>(
      builder: (context, serviceCliente, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Clientes'),
          ),
          body: StreamSnapshotBuilder<List<Cliente>>(
            stream: serviceCliente.streamAll(),
            isEmpty: (data) {
              return data == null || data.isEmpty;
            },
            builder: (context, data) {
              return CustomListView<Cliente>(
                data: data,
                childBuilder: (context, data) {
                  return Padding(
                    child: ListTile(
                      title: Text(
                        data.nome,
                      ),
                      subtitle: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text('Email: ${data.email}'),
                          const SizedBox(height: 10),
                          Text('Telefone: ${data.telefone}'),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  );
                },
                onTapEdit: (context, data) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClienteForm(
                        title: 'Editar Cliente',
                        cliente: data,
                      ),
                    ),
                  );
                },
                onAcceptDelete: (context, data) async {
                  serviceCliente.remove(data).whenComplete(() {
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
                  builder: (context) => ClienteForm(
                    title: 'Editar Cliente',
                    cliente: Cliente(
                      nome: '',
                      cpf: '',
                      telefone: '',
                      email: '',
                    ),
                  ),
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
