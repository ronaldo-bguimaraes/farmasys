import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_form.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoReceitaList extends StatefulWidget {
  static const String routeName = '/tipo_receita-list';

  const TipoReceitaList({Key? key}) : super(key: key);

  @override
  State<TipoReceitaList> createState() => _TipoReceitaListState();
}

class _TipoReceitaListState extends State<TipoReceitaList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IServiceTipoReceita>(
      builder: (context, serviceTipoReceita, _) {
        return Scaffold(
          body: StreamSnapshotBuilder<List<TipoReceita>>(
            stream: serviceTipoReceita.streamAll(),
            isEmpty: (data) {
              return data == null || data.isEmpty;
            },
            builder: (context, tipoReceita) {
              return CustomListView<TipoReceita>(
                data: tipoReceita,
                childBuilder: (context, tipoReceita) {
                  return Text(
                    tipoReceita.descricao,
                  );
                },
                onTapEdit: (context, data) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TipoReceitaForm(
                          title: 'Editar tipo de receita',
                          tipoReceita: data,
                        );
                      },
                    ),
                  );
                },
                onAcceptDelete: (context, tipoReceita) async {
                  serviceTipoReceita.remove(tipoReceita).whenComplete(() {
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
                    return TipoReceitaForm(
                      title: 'Cadastrar tipo de receita',
                      tipoReceita: TipoReceita(
                        descricao: '',
                        validade: 0,
                      ),
                    );
                  },
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
