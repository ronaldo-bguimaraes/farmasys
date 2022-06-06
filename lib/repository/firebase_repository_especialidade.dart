import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';

class FirebaseRepositoryEspecialidade<T extends Especialidade> extends FirebaseRepositoryBase<T> implements IRepositoryEspecialidade<T> {
  FirebaseRepositoryEspecialidade(IMapperEspecialidade<T> mapper) : super('especialidades', mapper);

  @override
  Future<T?> getByDescricao(String descricao) async {
    final query = await collecion.where('descricao', isEqualTo: descricao).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }
}
