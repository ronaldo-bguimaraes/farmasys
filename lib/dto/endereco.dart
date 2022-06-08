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
    this.cep = '',
    this.uf = '',
    this.cidade = '',
    this.bairro = '',
    this.rua = '',
    this.numero = '',
    this.complemento = '',
  });
}
