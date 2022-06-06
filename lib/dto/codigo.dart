import 'package:farmasys/dto/inteface/i_dto.dart';

class Codigo extends IDto {
  String uf;
  String codigo;

  Codigo({
    required this.uf,
    required this.codigo,
  });
}
