import 'package:farmasys/dto/crm.dart';
import 'package:farmasys/mapper/interface/i_mapper_crm.dart';

class MapperCRM implements IMapperCRM {
  @override
  Map<String, dynamic> toMap(CRM crm) {
    return {
      'uf': crm.uf?.trim(),
      'codigo': crm.codigo.trim(),
    };
  }

  @override
  CRM fromMap(Map<String, dynamic> map) {
    return CRM(
      uf: map['uf'],
      codigo: map['codigo'],
    );
  }
}