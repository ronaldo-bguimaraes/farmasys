import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';

class FirebaseRepositoryMedicamento<T extends Medicamento> extends FirebaseRepositoryBase<T> implements IRepositoryMedicamento<T> {
  FirebaseRepositoryMedicamento(IMapperMedicamento<T> mapper) : super('medicamentos', mapper);
}
