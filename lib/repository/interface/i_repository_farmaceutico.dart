import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_usuario.dart';

abstract class IRepositoryFarmaceutico<T extends Farmaceutico> extends IRepositoryUsuario<T> {}
