import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceTipoReceita extends ServiceEntityBase<TipoReceita> implements IServiceTipoReceita {
  // ignore: unused_field
  final IRepositoryTipoReceita _repositoryTipoReceita;

  final IRepositoryListaControle _repositoryListaControle;

  ServiceTipoReceita(this._repositoryTipoReceita, this._repositoryListaControle) : super(_repositoryTipoReceita);

  @override
  Future<List<TipoReceita>> getAll([IEntity? relatedEntity]) async {
    final tiposReceita = await super.getAll();
    tiposReceita.sort((a, b) => a.nome.compareTo(b.nome));
    return tiposReceita;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(TipoReceita tipoReceita) async {
    if (tipoReceita.id == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id do tipo de receita não pode ser nulo.',
      );
    }
    ListaControle? listaControle = await _repositoryListaControle.getByTipoReceita(tipoReceita);
    if (listaControle != null) {
      throw ExceptionMessage(
        code: 'em-uso',
        message: 'O tipo de receita está em uso.',
      );
    }
    //
    else {
      await super.remove(tipoReceita);
    }
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<TipoReceita> save(TipoReceita tipoReceita) async {
    final nome = tipoReceita.nome;
    if (nome == '') {
      throw ExceptionMessage(
        code: 'nome-vazio',
        message: 'O nome do tipo de receita não pode ser vazio.',
      );
    }
    if (tipoReceita.id == null) {
      if (await _repositoryTipoReceita.getByNome(nome) == null) {
        return super.save(tipoReceita);
      }
      //
      else {
        throw ExceptionMessage(
          code: 'existe',
          message: 'O tipo de receita já existe.',
        );
      }
    }
    return super.save(tipoReceita);
  }

  @override
  Stream<List<TipoReceita>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().map((tiposReceita) {
      tiposReceita.sort((a, b) => a.nome.compareTo(b.nome));
      return tiposReceita;
    });
  }
}
