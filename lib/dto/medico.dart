import 'package:farmasys/dto/crm.dart';
import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/inteface/i_entity.dart';

class Medico implements IEntity {
  @override
  String? id;
  String nome;
  String telefone;
  CRM crm;
  String? especialidadeId;
  Especialidade? especialidade;

  Medico({
    this.id,
    this.nome = '',
    this.telefone = '',
    CRM? crm,
    this.especialidadeId,
    this.especialidade,
  }) : crm = crm ?? CRM();
}
