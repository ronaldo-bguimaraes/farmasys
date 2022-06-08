import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/mapper/interface/i_mapper_principio_ativo.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_principio_ativo.dart';

class FirebaseRepositoryPrincipioAtivo extends FirebaseRepositoryBase<PrincipioAtivo> implements IRepositoryPrincipioAtivo {
  // ignore: unused_field
  final IMapperPrincipioAtivo _mapper;

  FirebaseRepositoryPrincipioAtivo(this._mapper) : super('principiosAtivos', _mapper);

  @override
  Future<PrincipioAtivo?> getByNome(String nome) async {
    final query = await firestore.collection(tableName).where('nome', isEqualTo: nome).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }

  @override
  Future<PrincipioAtivo?> getByListaControle(ListaControle listaControle) async {
    final query = await firestore.collection(tableName).where('listaControleId', isEqualTo: listaControle.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return _mapper.fromMap(map);
  }
}
