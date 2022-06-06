import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceMedico<T extends Medico, U extends Especialidade> extends ServiceEntityBase<T> implements IServiceMedico<T> {
  // ignore: unused_field
  final IRepositoryMedico<T> _repositoryMedico;

  final IRepositoryEspecialidade<U> _repositoryEspecialidade;

  ServiceMedico(this._repositoryMedico, this._repositoryEspecialidade) : super(_repositoryMedico);

  @override
  Future<List<T>> all() async {
    final medicos = await super.all();
    return await Future.wait(
      medicos.map((medico) async {
        medico.especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId!);
        return medico;
      }),
    );
  }

  @override
  Future<T?> getById(String id) async {
    final medico = await super.getById(id);
    if (medico != null) {
      medico.especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId!);
    }
    return medico;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> save(T medico) {
    if (medico.especialidadeId == null) {
      throw Exception('A propriedade especialidadeId não pode ser nula!');
    }
    return super.save(medico);
  }

  @override
  Stream<List<T>> streamAll() {
    return super.streamAll().asyncMap((medicos) async {
      return await Future.wait(
        medicos.map((medico) async {
          medico.especialidade = await _repositoryEspecialidade.getById(medico.especialidadeId!);
          return medico;
        }),
      );
    });
  }
}
