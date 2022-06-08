import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';

class FirebaseRepositoryEspecialidade extends FirebaseRepositoryBase<Especialidade> implements IRepositoryEspecialidade {
  // ignore: unused_field
  final IMapperEspecialidade _mapper;

  FirebaseRepositoryEspecialidade(this._mapper) : super('especialidades', _mapper);

  @override
  Future<Especialidade?> getByNome(String descricao) async {
    final query = await firestore.collection(tableName).where('nome', isEqualTo: descricao).get();
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
