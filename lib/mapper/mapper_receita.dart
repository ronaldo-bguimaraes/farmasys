import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';

class MapperReceita implements IMapperReceita {
  final IMapperItemReceita _mapperItemReceita;
  final IMapperNotificacao _mapperNotificacao;

  MapperReceita(this._mapperItemReceita, this._mapperNotificacao);

  @override
  Map<String, dynamic> toMap(Receita receita) {
    final notificacao = receita.notificacao;
    return {
      'id': receita.id,
      'medicoId': receita.medicoId,
      'clienteId': receita.clienteId,
      'farmaceuticoId': receita.farmaceuticoId,
      'tipoReceitaId': receita.tipoReceitaId,
      'notificacao': notificacao != null ? _mapperNotificacao.toMap(notificacao) : null,
      'dataEmissao': receita.dataEmissao?.toIso8601String(),
      'item': _mapperItemReceita.toMap(receita.item),
      'frequencia': receita.frequencia.toInt(),
    };
  }

  @override
  Receita fromMap(Map<String, dynamic> map) {
    final notificacao = map['notificacao'];
    return Receita(
      id: map['id'],
      medicoId: map['medicoId'],
      clienteId: map['clienteId'],
      farmaceuticoId: map['farmaceuticoId'],
      tipoReceitaId: map['tipoReceitaId'],
      notificacao: notificacao != null ? _mapperNotificacao.fromMap(notificacao) : null,
      dataEmissao: DateTime.parse(map['dataEmissao']),
      item: _mapperItemReceita.fromMap(map['item']),
      frequencia: map['frequencia'].toInt(),
    );
  }
}
