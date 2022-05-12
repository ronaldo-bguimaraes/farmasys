import 'package:farmasys/dto/inteface/entity_base.dart';

class Endereco extends EntityBase {
  String cep;
  String uf;
  String cidade;
  String bairro;
  String rua;
  String numero;
  String complemento;

  Endereco({
    required this.cep,
    required this.uf,
    required this.cidade,
    required this.bairro,
    required this.rua,
    required this.numero,
    required this.complemento,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'uf': uf,
      'cidade': cidade,
      'bairro': bairro,
      'rua': rua,
      'numero': numero,
      'complemento': complemento,
    };
  }

  Endereco.fromMap(Map<String, dynamic> map)
      : cep = map['cep'],
        uf = map['uf'],
        cidade = map['cidade'],
        bairro = map['bairro'],
        rua = map['rua'],
        numero = map['numero'],
        complemento = map['complemento'];
}
