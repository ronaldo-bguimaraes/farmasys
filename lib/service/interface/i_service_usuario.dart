import 'package:farmasys/dto/inteface/i_usuario.dart';
import 'package:farmasys/service/interface/i_service_entity.dart';

abstract class IServiceUsuario<T extends IUsuario> extends IServiceEntity<T> {
  Future<T?> getCurrentUser();
  Future<void> signUp(T user);
  Future<void> signIn(T user);
  Future<void> signOut();
}
