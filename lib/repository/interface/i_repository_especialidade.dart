import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryEspecialidade extends IRepository<Especialidade> {
  Future<Especialidade?> getByNome(String nome);
}
