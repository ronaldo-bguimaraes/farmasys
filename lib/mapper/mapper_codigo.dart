import 'package:farmasys/dto/codigo.dart';
import 'package:farmasys/mapper/interface/i_mapper_codigo.dart';

class MapperCodigo implements IMapperCodigo {
  @override
  Map<String, dynamic> toMap(Codigo codigo) {
    return {
      'uf': codigo.uf.trim(),
      'codigo': codigo.codigo.trim(),
    };
  }

  @override
  Codigo fromMap(Map<String, dynamic> map) {
    return Codigo(
      uf: map['uf'],
      codigo: map['codigo'],
    );
  }
}
