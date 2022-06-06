import 'package:farmasys/dto/endereco.dart';
import 'package:farmasys/mapper/interface/i_mapper_endereco.dart';

class MapperEndereco implements IMapperEndereco {
  @override
  Map<String, dynamic> toMap(Endereco endereco) {
    return {
      'id': endereco.id,
      'cep': endereco.cep.trim(),
      'uf': endereco.uf.trim(),
      'cidade': endereco.cidade.trim(),
      'bairro': endereco.bairro.trim(),
      'rua': endereco.rua.trim(),
      'numero': endereco.numero.trim(),
      'complemento': endereco.complemento.trim(),
    };
  }

  @override
  Endereco fromMap(Map<String, dynamic> map) {
    return Endereco(
      id: map['id'],
      cep: map['cep'],
      uf: map['uf'],
      cidade: map['cidade'],
      bairro: map['bairro'],
      rua: map['rua'],
      numero: map['numero'],
      complemento: map['complemento'],
    );
  }
}
