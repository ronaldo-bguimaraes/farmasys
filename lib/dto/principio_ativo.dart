import 'package:farmasys/dto/crm.dart';
import 'package:farmasys/dto/inteface/entity_base.dart';

class Medico extends EntityBase {
  String nome;
  String especialidade;
  String telefone;
  CRM crm;

  Medico({
    required this.nome,
    required this.especialidade,
    required this.telefone,
    required this.crm,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'especialidade': especialidade,
      'telefone': telefone,
      'crm': crm.toMap(),
    };
  }

  Medico.fromMap(Map<String, dynamic> map)
      : nome = map['nome'],
        especialidade = map['especialidade'],
        telefone = map['telefone'],
        crm = CRM.fromMap(map['crm']);
}
