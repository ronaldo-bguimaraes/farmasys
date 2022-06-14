import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/receita/receita_view.dart';
import 'package:farmasys/screen/receita/receita_form.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceitaList extends StatefulWidget {
  const ReceitaList({Key? key}) : super(key: key);

  @override
  State<ReceitaList> createState() => _ReceitaListState();
}

class _ReceitaListState extends State<ReceitaList> {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Receita>>(
        stream: ctx.read<IServiceReceita>().streamAll(),
        showChild: (receitas) {
          return receitas != null && receitas.isNotEmpty;
        },
        builder: (ctx, receitas) {
          return EntityListView<Receita>(
            items: receitas,
            childBuilder: (ctx, receita) {
              return Column(
                children: [
                  Text(
                    'Data de dispensação: ${_dateFormat.format(receita.dataDispensacao!)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Data de emissão: ${_dateFormat.format(receita.dataEmissao!)}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medicamento: ${receita.item.medicamento.nome} ${receita.item.medicamento.miligramas} mg (${receita.item.quantidade} caixas)',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Médico: ${receita.medico.nome}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Cliente: ${receita.cliente.nome}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Valor Total: R\$ ${receita.item.preco * receita.item.quantidade}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              );
            },
            editShow: (ctx, receita) {
              ReceitaView.show(ctx, receita);
              // ScaffoldMessenger.of(ctx).showSnackBar(
              //   const SnackBar(
              //     content: Text('A edição de receita ainda não foi implementada.'),
              //     duration: Duration(milliseconds: 1200),
              //   ),
              // );
            },
            removeAction: ctx.read<IServiceReceita>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ReceitaForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
