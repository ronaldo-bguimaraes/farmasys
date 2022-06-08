import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/service/interface/i_service_entity.dart';

abstract class IServiceMedicamento extends IServiceEntity<Medicamento> {
  Future<Medicamento?> getByPrincipioAtivo(PrincipioAtivo principioAtivo);
}
