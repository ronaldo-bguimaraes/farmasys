import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/lista_controle.dart';

class PrincipioAtivo implements IEntity {
  @override
  String? id;
  String nome;
  String? listaControleId;
  ListaControle? listaControle;

  PrincipioAtivo({
    this.id,
    this.nome = '',
    this.listaControleId,
    this.listaControle,
  });
}
