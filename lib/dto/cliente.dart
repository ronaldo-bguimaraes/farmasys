import 'package:farmasys/dto/inteface/entity_base.dart';

class Cliente extends EntityBase {
  String nome;
  String cpf;
  String telefone;
  String email;
  // Endereco endereco;

  Cliente({
    required this.nome,
    required this.cpf,
    required this.telefone,
    // required this.endereco,
    required this.email,
  });

  // a senha não será salva no banco
  @override
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cpf': cpf,
      'telefone': telefone,
      // 'endereco': endereco.toMap(),
      'email': email,
    };
  }

  Cliente.fromMap(Map<String, dynamic> map)
      : nome = map['nome'],
        cpf = map['cpf'],
        telefone = map['telefone'],
        // endereco = Endereco.fromMap(map['endereco']),
        email = map['email'];
}
