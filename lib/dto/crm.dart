import 'package:farmasys/dto/inteface/i_dto.dart';

class CRM extends IDto {
  String? uf;
  String codigo;

  CRM({
    this.uf,
    this.codigo = '',
  });
}
