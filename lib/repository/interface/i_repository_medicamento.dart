import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryMedicamento extends IRepository<Medicamento> {
  Future<Medicamento?> getByPrincipioAtivo(PrincipioAtivo principioAtivo);
}