import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/service_entity_base.dart';

class ServiceListaControle<T extends ListaControle> extends ServiceEntityBase<T> implements IServiceListaControle<T> {
  // ignore: unused_field
  final IRepositoryListaControle<T> _repositoryListaControle;

  ServiceListaControle(this._repositoryListaControle) : super(_repositoryListaControle);
}
