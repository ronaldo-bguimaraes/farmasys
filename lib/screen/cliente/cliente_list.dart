import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/screen/cliente/cliente_form.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
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
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: StreamSnapshotBuilder<List<Cliente>>(
        stream: ctx.read<IServiceCliente>().streamAll(),
        showChild: (clientes) {
          return clientes != null && clientes.isNotEmpty;
        },
        builder: (ctx, clientes) {
          return EntityListView<Cliente>(
            items: clientes,
            childBuilder: (ctx, cliente) {
              return Column(
                children: [
                  Text(
                    cliente.nome,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${cliente.email}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Telefone: ${cliente.telefone}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: ClienteForm.show,
            removeAction: ctx.read<IServiceCliente>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ClienteForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
