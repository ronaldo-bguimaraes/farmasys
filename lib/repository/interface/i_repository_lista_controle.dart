import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryListaControle extends IRepository<ListaControle> {
  Future<ListaControle?> getByTipoNotificacao(TipoNotificacao notificacao);
  Future<ListaControle?> getByTipoReceita(TipoReceita receita);
}