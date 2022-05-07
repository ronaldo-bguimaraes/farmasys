import 'package:farmasys/dto/inteface/dto.dart';

abstract class UserDto extends Dto {
  String nome;
  String telefone;
  String email;
  String senha;

  UserDto({
    required this.nome,
    required this.telefone,
    required this.email,
    required this.senha,
  });

}
