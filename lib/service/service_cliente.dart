import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/service/service_entity_base.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';

class ServiceCliente<T extends Cliente> extends ServiceEntityBase<T> implements IServiceCliente<T> {
  // ignore: unused_field
  final IRepositoryCliente<T> _repositoryCliente;

  ServiceCliente(this._repositoryCliente) : super(_repositoryCliente);
}
