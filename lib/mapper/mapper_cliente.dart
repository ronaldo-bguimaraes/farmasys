import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';

class MapperCliente<T extends Cliente> implements IMapperCliente {
  @override
  Map<String, dynamic> toMap(Cliente cliente) {
    return {
      'id': cliente.id,
      'nome': cliente.nome.trim(),
      'cpf': cliente.cpf.trim(),
      'telefone': cliente.telefone.trim(),
      'email': cliente.email.trim(),
    };
  }

  @override
  Cliente fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      telefone: map['telefone'],
      email: map['email'],
    );
  }
}
