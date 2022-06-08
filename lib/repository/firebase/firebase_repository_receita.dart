import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';

class FirebaseRepositoryReceita extends FirebaseRepositoryBase<Receita> implements IRepositoryReceita {
  // ignore: unused_field
  final IMapperReceita _mapper;

  FirebaseRepositoryReceita(this._mapper) : super('receitas', _mapper);

  @override
  Future<Receita?> getByNotificacao(Notificacao notificacao) async {
    final query = await firestore.collection('$tableName.notificacao.codigo').where('uf', isEqualTo: notificacao.codigo.uf).where('codigo', isEqualTo: notificacao.codigo.codigo).get();
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
