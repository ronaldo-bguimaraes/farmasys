import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/service/firebase/firebase_service_authentication_base.dart';
import 'package:farmasys/service/interface/i_service_authentication_farmaceutico.dart';

class ServiceFirebaseAuthenticationFarmaceutico extends ServiceFirebaseAuthenticationBase<Farmaceutico> implements IServiceAuthenticationFarmaceutico {
  // ignore: unused_field
  final IRepositoryFarmaceutico _repositotyUsuario;

  ServiceFirebaseAuthenticationFarmaceutico(this._repositotyUsuario) : super(_repositotyUsuario);
}
