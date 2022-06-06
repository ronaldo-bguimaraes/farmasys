import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_authentication.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:farmasys/service/service_usuario.dart';

class ServiceFarmaceutico<T extends Farmaceutico> extends ServiceUsuario<T> implements IServiceFarmaceutico<T> {
  // ignore: unused_field
  final IRepositoryFarmaceutico<T> _repositoryFarmaceutico;
  // ignore: unused_field
  final IServiceAuthentication<T> _authFarmaceutico;

  ServiceFarmaceutico(this._repositoryFarmaceutico, this._authFarmaceutico) : super(_repositoryFarmaceutico, _authFarmaceutico);
}
