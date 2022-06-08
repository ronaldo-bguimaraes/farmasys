import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/venda.dart';
import 'package:farmasys/mapper/interface/i_mapper_venda.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_venda.dart';

class FirebaseRepositoryVenda extends FirebaseRepositoryBase<Venda> implements IRepositoryVenda {
  // ignore: unused_field
  final IMapperVenda _mapper;

  FirebaseRepositoryVenda(this._mapper) : super('vendas', _mapper);

  @override
  Future<Venda?> getByCliente(Cliente cliente) async {
    final query = await firestore.collection(tableName).where('clienteId', isEqualTo: cliente.id).get();
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
