import 'package:farmasys/service/interface/authentication_service.dart';
import 'package:farmasys/dto/inteface/user_base.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticator<T extends UserBase> extends IAuthenticator<T> {
  final IRepository<T> _repository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuthenticator(this._repository);

  @override
  Future<void> createUserWithEmailAndPassword(T user) async {
    if (user.senha == null) {
      throw Exception('Password cannot be null');
    }
    var userCredential = await _auth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.senha!,
    );
    if (userCredential.user != null) {
      // set firestore user data
      user.id = userCredential.user!.uid;
      //
      await _repository.update(user);
    }
  }

  @override
  Stream<Future<T?>> getUserChanges() {
    return _auth.userChanges().map((userCredential) async {
      if (userCredential != null) {
        return _repository.get(userCredential.uid);
      }
      return Future.value(null);
    });
  }

  @override
  Future<T?> getCurrentUser() async {
    return await _repository.get(_auth.currentUser!.uid);
  }

  @override
  Future<void> signInWithEmailAndPassword(T user) async {
    if (user.senha == null) {
      throw Exception('Password cannot be null');
    }
    var userCredential = await _auth.signInWithEmailAndPassword(
      email: user.email,
      password: user.senha!,
    );
    if (userCredential.user != null) {
      // get firestore user data
      await _repository.get(userCredential.user!.uid);
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
