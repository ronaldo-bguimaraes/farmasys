import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/repository/interface/repository.dart';

class MedicoService<T extends Medico> {
  final IRepository<T> _medicoRepository;

  MedicoService(this._medicoRepository);

  Future<void> add(T medico) async {
    _medicoRepository.add(medico);
  }

  Stream<List<T>> all() {
    return _medicoRepository.streamAll();
  }

  Future<void> update(T medico) async {
    _medicoRepository.update(medico);
  }

  Future<void> delete(T medico) async {
    _medicoRepository.delete(medico);
  }

  Future<T?> get(String id) async {
    return _medicoRepository.get(id);
  }
}
