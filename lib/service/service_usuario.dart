import 'package:farmasys/repository/interface/i_repository_usuario.dart';
import 'package:farmasys/service/interface/i_service_authentication.dart';
import 'package:farmasys/dto/inteface/i_usuario.dart';
import 'package:farmasys/service/interface/i_service_usuario.dart';
import 'package:farmasys/service/service_entity_base.dart';

abstract class ServiceUsuario<T extends IUsuario> extends ServiceEntityBase<T> implements IServiceUsuario<T> {
  // ignore: unused_field
  final IRepositoryUsuario<T> _repositoryUsuario;

  final IServiceAuthentication<T> _authUsuario;

  ServiceUsuario(this._repositoryUsuario, this._authUsuario) : super(_repositoryUsuario);

  @override
  Future<T?> getCurrentUser() async {
    return await _authUsuario.getCurrentUser();
  }

  @override
  Future<void> signUp(T usuario) async {
    return await _authUsuario.createUserWithEmailAndPassword(usuario);
  }

  @override
  Future<void> signIn(T usuario) async {
    return await _authUsuario.signInWithEmailAndPassword(usuario);
  }

  @override
  Future<void> signOut() async {
    await _authUsuario.signOut();
  }
}
