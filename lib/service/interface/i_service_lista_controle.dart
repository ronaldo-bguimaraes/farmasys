import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_entity.dart';

abstract class IServiceListaControle extends IServiceEntity<ListaControle> {
  Future<ListaControle?> getByTipoNotificacao(TipoNotificacao tipoNotificacao);
}
