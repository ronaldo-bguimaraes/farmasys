import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryMedico extends IRepository<Medico> {
  Future<Medico?> getByEspecialidade(Especialidade especialidade);
}