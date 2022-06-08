import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';

class FirebaseRepositoryMedico extends FirebaseRepositoryBase<Medico> implements IRepositoryMedico {
  // ignore: unused_field
  final IMapperMedico _mapper;

  FirebaseRepositoryMedico(this._mapper) : super('medicos', _mapper);

  @override
  Future<Medico?> getByEspecialidade(Especialidade especialidade) async {
    final query = await firestore.collection(tableName).where('especialidadeId', isEqualTo: especialidade.id).get();
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
