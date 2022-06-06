import 'package:farmasys/dto/inteface/i_entity.dart';

class Especialidade implements IEntity {
  @override
  String? id;
  String descricao;

  Especialidade({
    this.id,
    required this.descricao,
  });
}
