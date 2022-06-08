import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';

class FirebaseRepositoryFarmaceutico extends FirebaseRepositoryBase<Farmaceutico> implements IRepositoryFarmaceutico {
  // ignore: unused_field
  final IMapperFarmaceutico _mapper;

  FirebaseRepositoryFarmaceutico(this._mapper) : super('farmaceuticos', _mapper);
}
