import 'package:farmasys/dto/item.dart';
import 'package:farmasys/repository/interface/i_repository_base.dart';

abstract class IRepositoryItem<T extends Item> extends IRepositoryBase<T> {}