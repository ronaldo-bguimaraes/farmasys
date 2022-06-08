import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/principio_ativo.dart';

class Medicamento implements IEntity {
  @override
  String? id;
  String nome;
  double miligramas;
  double preco;
  int quantidade;
  String? principioAtivoId;
  PrincipioAtivo principioAtivo;
  int comprimidos;

  Medicamento({
    this.id,
    this.nome = '',
    this.miligramas = 0,
    this.preco = 0,
    this.quantidade = 0,
    this.principioAtivoId,
    PrincipioAtivo? principioAtivo,
    this.comprimidos = 0,
  }) : principioAtivo = principioAtivo ?? PrincipioAtivo();
}
