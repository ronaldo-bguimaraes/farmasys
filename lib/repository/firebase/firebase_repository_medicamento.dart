import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';

class FirebaseRepositoryMedicamento extends FirebaseRepositoryBase<Medicamento> implements IRepositoryMedicamento {
  // ignore: unused_field
  final IMapperMedicamento _mapper;
  
  FirebaseRepositoryMedicamento(this._mapper) : super('medicamentos', _mapper);

  @override
  Future<Medicamento?> getByPrincipioAtivo(PrincipioAtivo principioAtivo) async {
    final query = await firestore.collection(tableName).where('principioAtivoId', isEqualTo: principioAtivo.id).get();
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
