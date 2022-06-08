import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryReceita extends IRepository<Receita> {
  Future<Receita?> getByNotificacao(Notificacao notificacao);
}