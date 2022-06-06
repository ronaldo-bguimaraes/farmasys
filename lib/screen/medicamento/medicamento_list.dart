import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/screen/builder/future_snapshot_builder.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/medicamento/medicamento_form.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_substancia.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<Medicamento>>(
        stream: context.read<IServiceMedicamento>().streamAll(),
        isEmpty: (medicamentos) {
          return medicamentos == null || medicamentos.isEmpty;
        },
        builder: (context, medicamentos) {
          return CustomListView<Medicamento>(
            data: medicamentos,
            childBuilder: (context, medicamento) {
              return ListTile(
                title: Text(
                  '${medicamento.nome} ${medicamento.miligramas}mg',
                ),
                subtitle: Text(
                  'Quantidade Disponível: ${medicamento.quantidade} unidades',
                ),
                contentPadding: EdgeInsets.zero,
              );
            },
            onTapEdit: (context, medicamento) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FutureSnapshotBuilder<List<Substancia>>(
                      future: context.read<IServiceSubstancia>().all(),
                      showChild: (substancias) {
                        return substancias == null;
                      },
                      builder: (context, substancias) {
                        return MedicamentoForm(
                          title: 'Editar Medicamento',
                          medicamento: medicamento,
                          substancias: substancias,
                        );
                      },
                    );
                  },
                ),
              );
            },
            onAcceptDelete: (context, data) async {
              context.read<IServiceMedicamento>().remove(data).whenComplete(() {
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
                return FutureSnapshotBuilder<List<Substancia>>(
                  future: context.read<IServiceSubstancia>().all(),
                  showChild: (substancias) {
                    return substancias == null;
                  },
                  builder: (context, substancias) {
                    return MedicamentoForm(
                      title: 'Editar Medicamento',
                      medicamento: Medicamento(
                        nome: '',
                        miligramas: 0,
                        preco: 0,
                        quantidade: 0,
                      ),
                      substancias: substancias,
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
  }
}
