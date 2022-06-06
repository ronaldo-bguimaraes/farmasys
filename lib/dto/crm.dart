import 'package:farmasys/dto/inteface/i_dto.dart';

class CRM extends IDto {
  String uf;
  String codigo;

  CRM({
    required this.codigo,
    required this.uf,
  });
}
