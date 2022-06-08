import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/enum/cor.dart';

class TipoNotificacao implements IEntity {
  @override
  String? id;
  String nome;
  Cor cor;

  TipoNotificacao({
    this.id,
    this.nome = '',
    this.cor = Cor.branca,
  });
}
