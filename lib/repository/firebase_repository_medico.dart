import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';

class FirebaseRepositoryMedico<T extends Medico> extends FirebaseRepositoryBase<T> implements IRepositoryMedico<T> {
  FirebaseRepositoryMedico(IMapperMedico<T> mapper) : super('medicos', mapper);
}
