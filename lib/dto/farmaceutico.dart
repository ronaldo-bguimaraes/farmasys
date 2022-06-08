// import 'package:farmasys/dto/endereco.dart';
import 'package:farmasys/dto/inteface/i_usuario.dart';

class Farmaceutico implements IUsuario {
  @override
  String? id;
  @override
  String nome;
  @override
  String telefone;
  @override
  String email;
  @override
  String senha;
  String cpf;

  Farmaceutico({
    this.id,
    this.nome = '',
    this.telefone = '',
    this.email = '',
    this.senha = '',
    this.cpf = '',
  });
}
