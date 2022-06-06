import 'package:farmasys/dto/inteface/i_usuario.dart';

abstract class IServiceAuthentication<T extends IUsuario> {
  Future<T?> getCurrentUser();
  Future<void> createUserWithEmailAndPassword(T usuario);
  Future<void> signInWithEmailAndPassword(T usuario);
  Future<void> signOut();
}
