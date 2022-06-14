import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';

class ServiceCliente extends ServiceEntityBase<Cliente> implements IServiceCliente {
  // ignore: unused_field
  final IRepositoryCliente _repositoryCliente;

  final IRepositoryReceita _repositoryReceita;

  ServiceCliente(this._repositoryCliente, this._repositoryReceita) : super(_repositoryCliente);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> remove(Cliente cliente) async {
    if (cliente.id == null) {
      throw ExceptionMessage(
        code: 'id-nulo',
        message: 'O id do cliente não pode ser nulo.',
      );
    }
    Receita? receita = await _repositoryReceita.getByCliente(cliente);
    if (receita != null) {
      throw ExceptionMessage(
        code: 'em-uso',
        message: 'O cliente está em uso.',
      );
    }
    //
    return await super.remove(cliente);
  }
}
