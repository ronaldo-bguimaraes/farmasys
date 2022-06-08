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
    this.nome = '',
    this.cpf = '',
    this.telefone = '',
    this.email = '',
  });
}
