import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_crm.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';

class MapperMedico implements IMapperMedico {
  final IMapperCRM _mapperCRM;

  MapperMedico(this._mapperCRM);

  @override
  Map<String, dynamic> toMap(Medico medico) {
    return {
      'id': medico.id,
      'nome': medico.nome.trim(),
      'telefone': medico.telefone.trim(),
      'crm': _mapperCRM.toMap(medico.crm),
      'especialidadeId': medico.especialidadeId,
    };
  }

  @override
  Medico fromMap(Map<String, dynamic> map) {
    return Medico(
      id: map['id'],
      nome: map['nome'],
      telefone: map['telefone'],
      crm: _mapperCRM.fromMap(map['crm']),
      especialidadeId: map['especialidadeId'],
    );
  }
}
