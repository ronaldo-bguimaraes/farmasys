import 'package:farmasys/dto/inteface/i_entity.dart';

class Endereco implements IEntity {
  @override
  String? id;
  String cep;
  String uf;
  String cidade;
  String bairro;
  String rua;
  String numero;
  String complemento;

  Endereco({
    this.id,
    required this.cep,
    required this.uf,
    required this.cidade,
    required this.bairro,
    required this.rua,
    required this.numero,
    required this.complemento,
  });
}
