import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/mapper/interface/i_mapper_substancia.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_substancia.dart';

class FirebaseRepositorySubstancia<T extends Substancia> extends FirebaseRepositoryBase<T> implements IRepositorySubstancia<T> {
  FirebaseRepositorySubstancia(IMapperSubstancia<T> mapper) : super('substancias', mapper);
}
