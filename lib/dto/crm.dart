import 'package:farmasys/dto/inteface/dto_base.dart';

class CRM extends DtoBase {
  String codigo;
  String uf;

  CRM({
    required this.codigo,
    required this.uf,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'uf': uf,
    };
  }

  CRM.fromMap(Map<String, dynamic> map)
      : codigo = map['codigo'],
        uf = map['uf'];
}
