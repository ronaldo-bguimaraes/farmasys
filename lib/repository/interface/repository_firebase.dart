import 'package:farmasys/dto/inteface/dto.dart';
import 'package:farmasys/repository/interface/repository.dart';

abstract class IRepositoryFirebase<T extends Dto> implements IRepository<T> {
  Stream<List<T>> listStream();
}
