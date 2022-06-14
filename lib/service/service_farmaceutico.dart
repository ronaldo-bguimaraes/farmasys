import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_authentication.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:farmasys/service/service_usuario.dart';

class ServiceFarmaceutico extends ServiceUsuario<Farmaceutico> implements IServiceFarmaceutico {
  // ignore: unused_field
  final IRepositoryFarmaceutico _repositoryFarmaceutico;
  // ignore: unused_field
  final IServiceAuthentication<Farmaceutico> _authFarmaceutico;

  ServiceFarmaceutico(
    this._repositoryFarmaceutico,
    this._authFarmaceutico
  ) : super(_repositoryFarmaceutico, _authFarmaceutico);

  @override
  Future<List<Farmaceutico>> getAll([IEntity? relatedEntity]) async {
    final farmaceuticos = await super.getAll();
    farmaceuticos.sort((a, b) => a.nome.compareTo(b.nome));
    return farmaceuticos;
  }

  @override
  Stream<List<Farmaceutico>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().map((farmaceuticos) {
      farmaceuticos.sort((a, b) => a.nome.compareTo(b.nome));
      return farmaceuticos;
    });
  }
}
