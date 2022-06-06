import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/screen/component/custom_listview.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/tipo_notificacao/tipo_notificacao_form.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoNotificacaoList extends StatefulWidget {
  static const String routeName = '/tipo-notificacao-list';

  const TipoNotificacaoList({Key? key}) : super(key: key);

  @override
  State<TipoNotificacaoList> createState() => _TipoNotificacaoListState();
}

class _TipoNotificacaoListState extends State<TipoNotificacaoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IServiceTipoNotificacao>(
      builder: (context, serviceTipoNotificacao, _) {
        return Scaffold(
          body: StreamSnapshotBuilder<List<TipoNotificacao>>(
            stream: serviceTipoNotificacao.streamAll(),
            isEmpty: (data) {
              return data == null || data.isEmpty;
            },
            builder: (context, tipoNotificacao) {
              return CustomListView<TipoNotificacao>(
                data: tipoNotificacao,
                childBuilder: (context, tipoReceita) {
                  return Text(
                    tipoReceita.descricao,
                  );
                },
                onTapEdit: (context, tipoNotificacao) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TipoNotificacaoForm(
                        title: 'Editar Notificação',
                        tipoNotificacao: tipoNotificacao,
                      ),
                    ),
                  );
                },
                onAcceptDelete: (context, tipoNotificacao) async {
                  serviceTipoNotificacao.remove(tipoNotificacao).whenComplete(() {
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
                  builder: (context) => TipoNotificacaoForm(
                    title: 'Editar Notificação',
                    tipoNotificacao: TipoNotificacao(
                      descricao: '',
                      validade: 0,
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
