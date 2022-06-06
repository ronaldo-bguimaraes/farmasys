import 'package:farmasys/dto/inteface/i_entity.dart';

class Cliente implements IEntity {
  @override
  String? id;
  String nome;
  String cpf;
  String telefone;
  String email;

  Cliente({
    this.id,
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.email,
  });
}
