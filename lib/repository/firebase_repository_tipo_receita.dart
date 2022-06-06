import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';

class FirebaseRepositoryTipoReceita<T extends TipoReceita> extends FirebaseRepositoryBase<T> implements IRepositoryTipoReceita<T> {
  FirebaseRepositoryTipoReceita(IMapperTipoReceita<T> mapper) : super('tiposReceita', mapper);
}
