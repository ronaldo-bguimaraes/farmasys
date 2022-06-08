import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/service/interface/i_service_lista_especialidade.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceEspecialidade extends ServiceEntityBase<Especialidade> implements IServiceEspecialidade {
  // ignore: unused_field
  final IRepositoryEspecialidade _repositoryEspecialidade;

  final IRepositoryMedico _repositoryMedico;

  ServiceEspecialidade(this._repositoryEspecialidade, this._repositoryMedico) : super(_repositoryEspecialidade);

  @override
  Future<List<Especialidade>> getAll([IEntity? relatedEntity]) async {
    final especialidades = await super.getAll();
    especialidades.sort((a, b) => a.nome.compareTo(b.nome));
    return especialidades;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Especialidade> save(Especialidade especialidade, [IEntity? relatedEntity]) async {
    final nome = especialidade.nome;
    if (nome == '') {
      throw ExceptionMessage(
        code: 'nome-vazio',
        message: 'O nome da especialidade não pode ser vazio.',
      );
    }
    if (especialidade.id == null) {
      if (await _repositoryEspecialidade.getByNome(nome) == null) {
        return super.save(especialidade);
      }
      //
      else {
        throw ExceptionMessage(
          code: 'existe',
          message: 'A especialidade já existe.',
        );
      }
    }
    return super.save(especialidade);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(Especialidade especialidade, [IEntity? relatedEntity]) async {
    if (especialidade.id == null) {
      throw ExceptionMessage(
        code: 'id-vazio',
        message: 'O id da especialidade não pode ser nulo.',
      );
    }

    Medico? medico = await _repositoryMedico.getByEspecialidade(especialidade);
    if (medico != null) {
      throw ExceptionMessage(
        code: 'em-uso',
        message: 'A especialidade está em uso.',
      );
    }
    //
    else {
      await super.remove(especialidade);
    }
  }

  @override
  Stream<List<Especialidade>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().map((especialidade) {
      especialidade.sort((a, b) => a.nome.compareTo(b.nome));
      return especialidade;
    });
  }
}
