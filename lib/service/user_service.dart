import 'dart:async';

import 'package:farmasys/service/interface/authentication_service.dart';
import 'package:farmasys/dto/inteface/user_base.dart';

class UserServiceFirebase<T extends UserBase> {
  final IAuthenticator<T> _auth;

  UserServiceFirebase(this._auth);

  Stream<Future<T?>> getUserChanges() {
    return _auth.getUserChanges();
  }

  Future<T?> getCurrentUser() async {
    return await _auth.getCurrentUser();
  }

  Future<void> signUp(T user) async {
    return await _auth.createUserWithEmailAndPassword(user);
  }

  Future<void> signIn(T user) async {
    return await _auth.signInWithEmailAndPassword(user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
