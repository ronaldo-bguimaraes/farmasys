import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/service/interface/i_service_lista_especialidade.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceEspecialidade<T extends Especialidade> extends ServiceEntityBase<T> implements IServiceEspecialidade<T> {
  // ignore: unused_field
  final IRepositoryEspecialidade<T> _repositoryEspecialidade;

  ServiceEspecialidade(this._repositoryEspecialidade) : super(_repositoryEspecialidade);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> save(T especialidade) async {
    if (especialidade.id == null) {
      if (await _repositoryEspecialidade.getByDescricao(especialidade.descricao) == null) {
        return super.save(especialidade);
      }
    }
    throw ExceptionMessage(
      code: 'especialidade-existe',
      message: 'A especialidade já existe!',
    );
  }
}
