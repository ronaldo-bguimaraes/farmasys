import 'package:farmasys/dto/inteface/user_base.dart';

abstract class IAuthenticator<T extends UserBase> {
  Future<T?> getCurrentUser();

  Future<void> createUserWithEmailAndPassword(T user);

  Future<void> signInWithEmailAndPassword(T user);

  Future<void> signOut();
}
