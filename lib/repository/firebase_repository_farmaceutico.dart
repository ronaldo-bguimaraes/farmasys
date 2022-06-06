import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';

class FirebaseRepositoryFarmaceutico<T extends Farmaceutico> extends FirebaseRepositoryBase<T> implements IRepositoryFarmaceutico<T> {
  FirebaseRepositoryFarmaceutico(IMapperFarmaceutico<T> mapper) : super('farmaceuticos', mapper);
}
