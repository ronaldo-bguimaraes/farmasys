import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryPrincipioAtivo extends IRepository<PrincipioAtivo> {
  Future<PrincipioAtivo?> getByNome(String nome);
  Future<PrincipioAtivo?> getByListaControle(ListaControle listaControle);
}