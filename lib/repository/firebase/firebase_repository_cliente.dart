import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';

class FirebaseRepositoryCliente extends FirebaseRepositoryBase<Cliente> implements IRepositoryCliente {
  // ignore: unused_field
  final IMapperCliente _mapper;

  FirebaseRepositoryCliente(this._mapper) : super('clientes', _mapper);
}
