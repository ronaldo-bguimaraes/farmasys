import 'package:farmasys/dto/inteface/i_usuario.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/exception/firebase_error.dart';
import 'package:farmasys/repository/interface/i_repository_usuario.dart';
import 'package:farmasys/service/interface/i_service_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ServiceFirebaseAuthenticationBase<T extends IUsuario> implements IServiceAuthentication<T> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final IRepositoryUsuario<T> _repositoryUsuario;

  ServiceFirebaseAuthenticationBase(this._repositoryUsuario);

  @override
  Future<void> createUserWithEmailAndPassword(T usuario) async {
    if (usuario.senha == null) {
      throw ExceptionMessage(
        code: 'auth/empty-password',
        message: 'A senha não pode ser vazia!',
      );
    }
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha!,
      );
      usuario.id = userCredential.user?.uid;
      await _repositoryUsuario.update(usuario);
    }
    //
    on FirebaseAuthException catch (error) {
      throw getExceptionMessageFromFirebaseException(error);
    }
  }

  @override
  Future<T?> getCurrentUser() async {
    return await _repositoryUsuario.getById(_auth.currentUser!.uid);
  }

  @override
  Future<void> signInWithEmailAndPassword(T usuario) async {
    if (usuario.senha == null) {
      throw ExceptionMessage(
        code: 'auth/empty-password',
        message: 'A senha não pode ser vazia!',
      );
    }
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha!,
      );
      if (userCredential.user != null) {
        // get firestore user data
        await _repositoryUsuario.getById(userCredential.user!.uid);
      }
    }
    //
    on FirebaseAuthException catch (error) {
      throw getExceptionMessageFromFirebaseException(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    }
    //
    on FirebaseAuthException catch (error) {
      throw getExceptionMessageFromFirebaseException(error);
    }
  }
}
