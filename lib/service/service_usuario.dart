import 'package:farmasys/dto/inteface/i_entity.dart';
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
  Future<T> signUp(T usuario) async {
    return await _authUsuario.createUserWithEmailAndPassword(usuario);
  }

  @override
  Future<T> signIn(T usuario) async {
    return await _authUsuario.signInWithEmailAndPassword(usuario);
  }

  @override
  Future<void> signOut() async {
    return await _authUsuario.signOut();
  }

  @override
  Future<List<T>> getAll([IEntity? relatedEntity]) async {
    final usuarios = await super.getAll();
    usuarios.sort((a, b) => a.nome.compareTo(b.nome));
    return usuarios;
  }

  @override
  Stream<List<T>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().map((usuarios) {
      usuarios.sort((a, b) => a.nome.compareTo(b.nome));
      return usuarios;
    });
  }
}
