import 'package:farmasys/dto/inteface/entity_base.dart';

abstract class UserBase extends EntityBase {
  String? nome;
  String? telefone;
  String email;
  String? senha;

  UserBase({
    this.nome,
    this.telefone,
    required this.email,
    this.senha,
  });
}
