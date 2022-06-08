import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/medicamento/medicamento_form.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicamentoList extends StatefulWidget {
  static const String routeName = '/medicamento-list';

  const MedicamentoList({Key? key}) : super(key: key);

  @override
  State<MedicamentoList> createState() => _MedicamentoListState();
}

class _MedicamentoListState extends State<MedicamentoList> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Medicamento>>(
        stream: ctx.read<IServiceMedicamento>().streamAll(),
        showChild: (medicamentos) {
          return medicamentos != null && medicamentos.isNotEmpty;
        },
        builder: (ctx, medicamentos) {
          return EntityListView<Medicamento>(
            items: medicamentos,
            childBuilder: (ctx, medicamento) {
              return Column(children: [
                Text(
                  '${medicamento.nome} ${medicamento.miligramas} mg',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Princípio ativo: ${medicamento.principioAtivo?.nome}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Text(
                  'Compromidos por caixa: ${medicamento.comprimidos}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Text(
                  'Quantidade Disponível: ${medicamento.quantidade} unidades',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Text(
                  'Preço: R\$ ${medicamento.preco}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ], crossAxisAlignment: CrossAxisAlignment.stretch);
            },
            editShow: MedicamentoForm.show,
            removeAction: ctx.read<IServiceMedicamento>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MedicamentoForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
