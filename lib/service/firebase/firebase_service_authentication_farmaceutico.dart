import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/service/firebase/firebase_service_authentication_base.dart';
import 'package:farmasys/service/interface/i_service_authentication_farmaceutico.dart';

class ServiceFirebaseAuthenticationFarmaceutico<T extends Farmaceutico> extends ServiceFirebaseAuthenticationBase<T> implements IServiceAuthenticationFarmaceutico<T> {
  // ignore: unused_field
  final IRepositoryFarmaceutico<T> _repositotyUsuario;

  ServiceFirebaseAuthenticationFarmaceutico(this._repositotyUsuario) : super(_repositotyUsuario);
}
