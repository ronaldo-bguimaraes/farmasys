import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';

class FirebaseRepositoryReceita extends FirebaseRepositoryBase<Receita> implements IRepositoryReceita {
  // ignore: unused_field
  final IMapperReceita _mapper;

  FirebaseRepositoryReceita(this._mapper) : super('receitas', _mapper);
}
