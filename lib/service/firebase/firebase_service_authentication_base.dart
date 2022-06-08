import 'package:farmasys/dto/inteface/i_usuario.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/exception/firebase_auth_error_map.dart';
import 'package:farmasys/repository/interface/i_repository_usuario.dart';
import 'package:farmasys/service/interface/i_service_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ServiceFirebaseAuthenticationBase<T extends IUsuario> implements IServiceAuthentication<T> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final IRepositoryUsuario<T> _repositoryUsuario;

  ServiceFirebaseAuthenticationBase(this._repositoryUsuario);

  @override
  T? currentUser;

  @override
  Future<T> createUserWithEmailAndPassword(T usuario) async {
    if (usuario.senha == '') {
      throw ExceptionMessage(
        code: 'empty-password',
        message: 'A senha não pode ser vazia.',
      );
    }
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );
      usuario.id = userCredential.user?.uid;
      return currentUser = await _repositoryUsuario.set(usuario);
    }
    //
    on FirebaseAuthException catch (error) {
      throw FirebaseAuthErrorMap.getExceptionMessage(error);
    }
  }

  @override
  Future<T> signInWithEmailAndPassword(T usuario) async {
    if (usuario.senha == '') {
      throw ExceptionMessage(
        code: 'empty-password',
        message: 'A senha não pode ser vazia.',
      );
    }
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha,
      );
      final user = userCredential.user;
      if (user != null) {
        // get firestore user data
        currentUser = await _repositoryUsuario.getById(user.uid);
        if (currentUser != null) {
          return Future.value(currentUser);
        }
        //
        else {
          throw ExceptionMessage(
            code: 'user-not-found',
            message: 'Usuário não encontrado no banco de dados',
          );
        }
      }
      //
      else {
        throw ExceptionMessage(
          code: 'user-not-found',
          message: 'Usuário não encontrado no banco de dados',
        );
      }
    }
    //
    on FirebaseAuthException catch (error) {
      throw FirebaseAuthErrorMap.getExceptionMessage(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await auth.signOut();
    }
    //
    on FirebaseAuthException catch (error) {
      throw FirebaseAuthErrorMap.getExceptionMessage(error);
    }
  }
}
