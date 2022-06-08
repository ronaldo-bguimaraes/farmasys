import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceTipoNotificacao extends ServiceEntityBase<TipoNotificacao> implements IServiceTipoNotificacao {
  // ignore: unused_field
  final IRepositoryTipoNotificacao _repositoryTipoNotificacao;

  final IRepositoryListaControle _repositoryListaControle;

  ServiceTipoNotificacao(this._repositoryTipoNotificacao, this._repositoryListaControle) : super(_repositoryTipoNotificacao);

  @override
  Future<List<TipoNotificacao>> getAll([IEntity? relatedEntity]) async {
    final tiposNotificacao = await super.getAll();
    tiposNotificacao.sort((a, b) => a.nome.compareTo(b.nome));
    return tiposNotificacao;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(TipoNotificacao tipoNotificacao, [IEntity? relatedEntity]) async {
    if (tipoNotificacao.id == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id do tipo de notificação não pode ser nulo.',
      );
    }
    ListaControle? listaControle = await _repositoryListaControle.getByTipoNotificacao(tipoNotificacao);
    if (listaControle != null) {
      throw ExceptionMessage(
        code: 'em-uso',
        message: 'O tipo de notificação está em uso.',
      );
    }
    //
    else {
      await super.remove(tipoNotificacao);
    }
  }

  @override
  Stream<List<TipoNotificacao>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().map((tiposNotificacao) {
      tiposNotificacao.sort((a, b) => a.nome.compareTo(b.nome));
      return tiposNotificacao;
    });
  }
}
