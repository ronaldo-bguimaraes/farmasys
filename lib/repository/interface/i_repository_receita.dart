import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/repository/interface/i_repository.dart';

abstract class IRepositoryReceita extends IRepository<Receita> {
  Future<Receita?> getByNotificacao(Notificacao notificacao);
  Future<Receita?> getByMedico(Medico medico);
  Future<Receita?> getByCliente(Cliente cliente);
  Future<Receita?> getByTipoReceita(TipoReceita tipoReceita);
  Future<Receita?> getByTipoNotificacao(TipoNotificacao tipoNotificacao);
  Future<Receita?> getByMedicamento(Medicamento medicamento);
}