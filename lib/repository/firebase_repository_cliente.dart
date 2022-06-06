import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';

class FirebaseRepositoryCliente<T extends Cliente> extends FirebaseRepositoryBase<T> implements IRepositoryCliente<T> {
  FirebaseRepositoryCliente(IMapperCliente<T> mapper) : super('clientes', mapper);
}
