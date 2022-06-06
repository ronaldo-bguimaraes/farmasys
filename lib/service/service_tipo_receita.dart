import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceTipoReceita<T extends TipoReceita> extends ServiceEntityBase<T> implements IServiceTipoReceita<T> {
  // ignore: unused_field
  final IRepositoryTipoReceita<T> _repositoryTipoReceita;

  ServiceTipoReceita(this._repositoryTipoReceita) : super(_repositoryTipoReceita);
}
