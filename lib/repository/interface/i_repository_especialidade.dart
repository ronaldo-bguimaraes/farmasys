import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_base.dart';

abstract class IRepositoryEspecialidade<T extends Especialidade> extends IRepositoryBase<T> {
  Future<T?> getByDescricao(String descricao);
}
