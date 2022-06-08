import 'package:farmasys/dto/inteface/i_entity.dart';

abstract class IUsuario implements IEntity {
  abstract String nome;
  abstract String telefone;
  abstract String email;
  abstract String senha;
}
