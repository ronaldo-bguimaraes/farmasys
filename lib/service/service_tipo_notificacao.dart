import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceTipoNotificacao<T extends TipoNotificacao> extends ServiceEntityBase<T> implements IServiceTipoNotificacao<T> {
  // ignore: unused_field
  final IRepositoryTipoNotificacao<T> _repositoryTipoNotificacao;

  ServiceTipoNotificacao(this._repositoryTipoNotificacao) : super(_repositoryTipoNotificacao);
}