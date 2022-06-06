import 'package:farmasys/dto/inteface/i_dto.dart';

abstract class IEntity extends IDto {
  String? id;
  IEntity({this.id});
}
