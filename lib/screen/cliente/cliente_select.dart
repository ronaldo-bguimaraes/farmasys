import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/screen/cliente/cliente_form.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClienteSelect extends StatefulWidget {
  const ClienteSelect({Key? key}) : super(key: key);

  @override
  State<ClienteSelect> createState() => _ClienteSelectState();

  static Future<Cliente?> show(BuildContext ctx) async {
    return await Navigator.of(ctx).push<Cliente?>(
      MaterialPageRoute(
        builder: (ctx) {
          return const ClienteSelect();
        },
      ),
    );
  }
}

class _ClienteSelectState extends State<ClienteSelect> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o cliente'),
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
            editShow: (ctx, cliente) {
              Navigator.of(ctx).pop(cliente);
            },
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
