import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/repository/interface/repository.dart';

class MedicamentoService<T extends Medicamento> {
  final IRepository<T> _medicamentoRepository;

  MedicamentoService(this._medicamentoRepository);

  Future<void> add(T medicamento) async {
    _medicamentoRepository.add(medicamento);
  }

  Stream<List<T>> all() {
    return _medicamentoRepository.all();
  }

  Future<void> update(T medicamento) async {
    _medicamentoRepository.update(medicamento);
  }

  Future<void> delete(T medicamento) async {
    _medicamentoRepository.delete(medicamento);
  }

  Future<T?> get(String id) async {
    return _medicamentoRepository.get(id);
  }
}
