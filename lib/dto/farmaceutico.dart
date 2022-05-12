// import 'package:farmasys/dto/endereco.dart';
import 'package:farmasys/dto/inteface/user_base.dart';

class Farmaceutico extends UserBase {
  String? cpf;
  // Endereco endereco;

  Farmaceutico({
    this.cpf,
    // required this.endereco,
    String? nome,
    String? telefone,
    required String email,
    required String? senha,
  }) : super(
          nome: nome,
          telefone: telefone,
          email: email,
          senha: senha,
        );

  // a senha não será salva no banco
  @override
  Map<String, dynamic> toMap() {
    return {
      'cpf': cpf,
      // 'endereco': endereco.toMap(),
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  Farmaceutico.fromMap(Map<String, dynamic> map)
      : cpf = map['cpf'],
        // endereco = Endereco.fromMap(map['endereco']),
        super(
          nome: map['nome'],
          telefone: map['telefone'],
          email: map['email'],
          senha: '',
        );
}
