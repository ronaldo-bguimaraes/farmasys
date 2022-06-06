import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_usuario.dart';

abstract class IServiceFarmaceutico<T extends Farmaceutico> extends IServiceUsuario<T> {}
