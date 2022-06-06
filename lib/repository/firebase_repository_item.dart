import 'package:farmasys/dto/item.dart';
import 'package:farmasys/mapper/interface/i_mapper_item.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_item.dart';

class FirebaseRepositoryItem<T extends Item> extends FirebaseRepositoryBase<T> implements IRepositoryItem<T> {
  FirebaseRepositoryItem(IMapperItem<T> mapperItem) : super('itens', mapperItem);
}
