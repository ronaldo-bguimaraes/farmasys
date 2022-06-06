import 'package:farmasys/dto/item.dart';
import 'package:farmasys/service/interface/i_service_entity.dart';

abstract class IServiceItem<T extends Item> implements IServiceEntity<T> {}
