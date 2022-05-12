import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/repository/interface/repository.dart';

class ClienteService<T extends Cliente> {
  final IRepository<T> _clienteRepository;

  ClienteService(this._clienteRepository);

  Future<void> add(T cliente) async {
    _clienteRepository.add(cliente);
  }

  Stream<List<T>> all() {
    return _clienteRepository.all();
  }

  Future<void> update(T cliente) async {
    _clienteRepository.update(cliente);
  }

  Future<void> delete(T cliente) async {
    _clienteRepository.delete(cliente);
  }

  Future<T?> get(String id) async {
    return _clienteRepository.get(id);
  }
}
