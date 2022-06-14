import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_principio_ativo.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceListaControle extends ServiceEntityBase<ListaControle> implements IServiceListaControle {
  // ignore: unused_field
  final IRepositoryListaControle _repositoryListaControle;

  final IRepositoryTipoReceita _repositoryTipoReceita;

  final IRepositoryTipoNotificacao _repositoryTipoNotificacao;

  final IRepositoryPrincipioAtivo _repositoryPrincipioAtivo;

  ServiceListaControle(
    this._repositoryListaControle,
    this._repositoryTipoReceita,
    this._repositoryTipoNotificacao,
    this._repositoryPrincipioAtivo,
  ) : super(_repositoryListaControle);

  Future<ListaControle> _getRelatedData(ListaControle listaControle) async {
    if (listaControle.tipoReceitaId != null) {
      final tipoReceita = await _repositoryTipoReceita.getById(listaControle.tipoReceitaId);
      if (tipoReceita != null) {
        listaControle.tipoReceita = tipoReceita;
      }
      //
      else {
        throw ExceptionMessage(
          code: 'erro-get-data',
          message: 'Erro ao buscar tipo de receita da lista de controle.',
        );
      }
    }
    if (listaControle.tipoNotificacaoId != null) {
      listaControle.tipoNotificacao = await _repositoryTipoNotificacao.getById(listaControle.tipoNotificacaoId);
    }
    return listaControle;
  }

  @override
  Future<List<ListaControle>> getAll([IEntity? relatedEntity]) async {
    final listasControle = await super.getAll();
    listasControle.sort((a, b) => a.nome.compareTo(b.nome));
    return await Future.wait(
      listasControle.map((listaControle) async {
        return await _getRelatedData(listaControle);
      }),
    );
  }

  @override
  Future<ListaControle?> getById(String? id) async {
    final listaControle = await super.getById(id);
    if (listaControle != null) {
      return await _getRelatedData(listaControle);
    }
    return listaControle;
  }

  @override
  Future<ListaControle?> getByTipoNotificacao(TipoNotificacao tipoNotificacao) async {
    final listaControle = await _repositoryListaControle.getByTipoNotificacao(tipoNotificacao);
    if (listaControle != null) {
      return await _getRelatedData(listaControle);
    }
    return listaControle;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(ListaControle listaControle) async {
    if (listaControle.id == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id da lista de controle não pode ser nulo.',
      );
    }
    PrincipioAtivo? principioAtivo = await _repositoryPrincipioAtivo.getByListaControle(listaControle);
    if (principioAtivo != null) {
      throw ExceptionMessage(
        code: 'em-uso',
        message: 'A lista de controle está em uso.',
      );
    }
    //
    await super.remove(listaControle);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<ListaControle> save(ListaControle listaControle) async {
    final nome = listaControle.nome;
    if (nome == '') {
      throw ExceptionMessage(
        code: 'nome-vazio',
        message: 'O nome da lista de controle não pode ser vazio.',
      );
    }
    if (listaControle.id == null) {
      if (await _repositoryListaControle.getByNome(nome) == null) {
        return super.save(listaControle);
      }
      //
      else {
        throw ExceptionMessage(
          code: 'existe',
          message: 'A lista de controle já existe.',
        );
      }
    }
    return super.save(listaControle);
  }

  @override
  Stream<List<ListaControle>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((listasControle) async {
      listasControle.sort((a, b) => a.nome.compareTo(b.nome));
      return await Future.wait(
        listasControle.map((listaControle) async {
          return await _getRelatedData(listaControle);
        }),
      );
    });
  }
}
