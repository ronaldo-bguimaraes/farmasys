import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';

class FirebaseRepositoryTipoReceita extends FirebaseRepositoryBase<TipoReceita> implements IRepositoryTipoReceita {
  // ignore: unused_field
  final IMapperTipoReceita _mapper;
  
  FirebaseRepositoryTipoReceita(this._mapper) : super('tiposReceita', _mapper);
}
