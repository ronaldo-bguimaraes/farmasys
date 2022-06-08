import 'package:farmasys/dto/inteface/i_entity.dart';

class Especialidade implements IEntity {
  @override
  String? id;
  String nome;

  Especialidade({
    this.id,
    this.nome = '',
  });
}
