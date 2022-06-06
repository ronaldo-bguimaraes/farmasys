import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';

class MapperFarmaceutico implements IMapperFarmaceutico {
  @override
  Map<String, dynamic> toMap(Farmaceutico farmaceutico) {
    return {
      'id': farmaceutico.id,
      'cpf': farmaceutico.cpf?.trim(),
      'nome': farmaceutico.nome?.trim(),
      'telefone': farmaceutico.telefone?.trim(),
      'email': farmaceutico.email.trim(),
      'senha': farmaceutico.senha?.trim(),
    };
  }

  @override
  Farmaceutico fromMap(Map<String, dynamic> map) {
    return Farmaceutico(
      id: map['id'],
      cpf: map['cpf'],
      nome: map['nome'],
      telefone: map['telefone'],
      email: map['email'],
      senha: map['senha'],
    );
  }
}
