import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/lista_controle.dart';

class Substancia implements IEntity {
  @override
  String? id;
  String nome;
  String? listaControleId;
  ListaControle? listaControle;

  Substancia({
    this.id,
    required this.nome,
    this.listaControleId,
    this.listaControle,
  });
}
