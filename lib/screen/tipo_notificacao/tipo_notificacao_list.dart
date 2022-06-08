import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/screen/component/entity_listview.dart';
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
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: StreamSnapshotBuilder<List<TipoNotificacao>>(
        stream: ctx.read<IServiceTipoNotificacao>().streamAll(),
        showChild: (tiposNotificacao) {
          return tiposNotificacao != null && tiposNotificacao.isNotEmpty;
        },
        builder: (ctx, tiposNotificacao) {
          return EntityListView<TipoNotificacao>(
            items: tiposNotificacao,
            childBuilder: (ctx, tipoNotificacao) {
              return Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: tipoNotificacao.cor.value,
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          tipoNotificacao.nome,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Cor: ${tipoNotificacao.cor.name.toUpperCase()}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                    ),
                  ),
                ],
              );
            },
            editShow: TipoNotificacaoForm.show,
            removeAction: ctx.read<IServiceTipoNotificacao>().remove,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TipoNotificacaoForm.show(ctx);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
