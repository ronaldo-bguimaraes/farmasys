import 'package:farmasys/dto/inteface/i_usuario.dart';

abstract class IServiceAuthentication<T extends IUsuario> {
  T? get currentUser;
  Future<T> createUserWithEmailAndPassword(T usuario);
  Future<T> signInWithEmailAndPassword(T usuario);
  Future<void> signOut();
}
