import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/venda.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryVenda extends IRepository<Venda> {
  Future<Venda?> getByCliente(Cliente cliente);
}