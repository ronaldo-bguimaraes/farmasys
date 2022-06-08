import 'package:farmasys/dto/inteface/i_usuario.dart';

abstract class IServiceAuthentication<T extends IUsuario> {
  Future<T?> getCurrentUser();
  Future<T> createUserWithEmailAndPassword(T usuario);
  Future<T> signInWithEmailAndPassword(T usuario);
  Future<void> signOut();
}
