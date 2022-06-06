import 'package:farmasys/dto/inteface/i_entity.dart';

abstract class IUsuario implements IEntity {
  String? nome;
  String? telefone;
  String email;
  String? senha;

  IUsuario({
    String? id,
    this.nome,
    this.telefone,
    required this.email,
    this.senha,
  });
}
