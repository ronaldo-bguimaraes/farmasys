import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';

class FirebaseRepositoryListaControle<T extends ListaControle> extends FirebaseRepositoryBase<T> implements IRepositoryListaControle<T> {
  FirebaseRepositoryListaControle(IMapperListaControle<T> mapper) : super('listasControle', mapper);
}
