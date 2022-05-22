import 'package:farmasys/dto/inteface/user_base.dart';

abstract class IAuthenticator<T extends UserBase> {
  Stream<Future<T?>> getUserChanges();

  Future<T?> getCurrentUser();

  Future<void> createUserWithEmailAndPassword(T user);

  Future<void> signInWithEmailAndPassword(T user);

  Future<void> signOut();
}
