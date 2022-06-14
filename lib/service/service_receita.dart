import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';
import 'package:intl/intl.dart';

class ServiceReceita extends ServiceEntityBase<Receita> implements IServiceReceita {
  final IRepositoryReceita _repositoryReceita;

  final IRepositoryMedico _repositoryMedico;

  final IRepositoryCliente _repositoryCliente;

  final IRepositoryFarmaceutico _repositoryFarmaceutico;

  final IServiceMedicamento _serviceMedicamento;

  final IServiceTipoNotificacao _serviceTipoNotificacao;

  final IServiceTipoReceita _serviceTipoReceita;

  ServiceReceita(
    this._repositoryReceita,
    this._repositoryMedico,
    this._repositoryCliente,
    this._repositoryFarmaceutico,
    this._serviceMedicamento,
    this._serviceTipoNotificacao,
    this._serviceTipoReceita,
  ) : super(_repositoryReceita);

  Future<Receita> _getRelatedData(Receita receita) async {
    final medico = await _repositoryMedico.getById(receita.medicoId);
    if (medico != null) {
      receita.medico = medico;
    }
    //
    else {
      throw ExceptionMessage(
        code: 'erro-get-data',
        message: 'Erro ao buscar médico da receita.',
      );
    }
    final cliente = await _repositoryCliente.getById(receita.clienteId);
    if (cliente != null) {
      receita.cliente = cliente;
    }
    //
    else {
      throw ExceptionMessage(
        code: 'erro-get-data',
        message: 'Erro ao buscar cliente da receita.',
      );
    }
    final farmaceutico = await _repositoryFarmaceutico.getById(receita.farmaceuticoId);
    if (farmaceutico != null) {
      receita.farmaceutico = farmaceutico;
    }
    //
    else {
      throw ExceptionMessage(
        code: 'erro-get-data',
        message: 'Erro ao buscar farmaceutico da receita.',
      );
    }
    final medicamento = await _serviceMedicamento.getById(receita.item.medicamentoId);
    if (medicamento != null) {
      receita.item.medicamento = medicamento;
    }
    //
    else {
      throw ExceptionMessage(
        code: 'erro-get-data',
        message: 'Erro ao buscar medicamento do item da receita.',
      );
    }
    if (receita.notificacao != null) {
      final tipoNotificacao = await _serviceTipoNotificacao.getById(receita.notificacao!.tipoNotificacaoId);
      if (tipoNotificacao != null) {
        receita.notificacao!.tipoNotificacao = tipoNotificacao;
      }
      //
      else {
        throw ExceptionMessage(
          code: 'erro-get-data',
          message: 'Erro ao buscar tipo de notificação da notificação da receita.',
        );
      }
    }
    final tipoReceita = await _serviceTipoReceita.getById(receita.tipoReceitaId);
    if (tipoReceita != null) {
      receita.tipoReceita = tipoReceita;
    }
    //
    else {
      throw ExceptionMessage(
        code: 'erro-get-data',
        message: 'Erro ao buscar tipo de receita da receita.',
      );
    }
    return receita;
  }

  @override
  Future<List<Receita>> getAll([IEntity? relatedEntity]) async {
    final receitas = await super.getAll();
    receitas.sort((a, b) => a.dataDispensacao!.compareTo(b.dataDispensacao!));
    return await Future.wait(
      receitas.map((receita) async {
        return await _getRelatedData(receita);
      }),
    );
  }

  @override
  Future<Receita?> getById(String? id) async {
    final receita = await super.getById(id);
    if (receita != null) {
      return await _getRelatedData(receita);
    }
    return receita;
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Receita> save(Receita receita) async {
    final dataEmissao = receita.dataEmissao;

    // verifica se a data de emissao não é nula
    if (dataEmissao == null) {
      throw ExceptionMessage(
        code: 'sem-data',
        message: 'A data de emissão da receita não pode ser nula',
      );
    }

    if (receita.item.quantidade > receita.item.medicamento.quantidade) {
      throw ExceptionMessage(
        code: 'sem-estoque',
        message: 'Só há ${receita.item.medicamento.quantidade} caixas em estoque.',
      );
    }

    final listaControle = receita.item.medicamento.principioAtivo.listaControle;

    final notificacaoReceita = receita.notificacao;

    if (listaControle == null && notificacaoReceita != null) {
      throw ExceptionMessage(
        code: 'notificacao-invalida',
        message: 'Esse medicamento não requer notificação de receita.',
      );
    }

    // verifica se o medicamento possui lista de controle
    if (listaControle != null) {
      final dataFinal = dataEmissao.add(Duration(days: listaControle.prazo));

      // verifica se a receita venceu
      if (DateTime.now().difference(dataEmissao).inDays < 0) {
        throw ExceptionMessage(
          code: 'inválida',
          message: 'A data de emissão é inválida',
        );
      }

      // verifica se a receita venceu
      if (DateTime.now().difference(dataEmissao).inDays > listaControle.prazo) {
        throw ExceptionMessage(
          code: 'vencida',
          message: 'A receita venceu em ${DateFormat("dd/MM/yyyy").format(dataFinal)}',
        );
      }

      final tipoNotificacaoControle = listaControle.tipoNotificacao;

      if (tipoNotificacaoControle != null) {
        if (notificacaoReceita == null) {
          throw ExceptionMessage(
            code: 'notificacao-faltando',
            message: 'Esse medicamento só permite a dispensação com notificação acompanhada da receita.',
          );
        }
        //
        else if (listaControle.tipoNotificacaoId != notificacaoReceita.tipoNotificacaoId) {
          throw ExceptionMessage(
            code: 'notificacao-incorreta',
            message: 'Esse medicamento só permite a dispensação com notificação do tipo ${tipoNotificacaoControle.nome} (${tipoNotificacaoControle.cor.name.toUpperCase()}).',
          );
        }
        final notificacao = await _repositoryReceita.getByNotificacao(notificacaoReceita);
        
        if (notificacao != null) {
          throw ExceptionMessage(
            code: 'existe',
            message: 'A notificação de receita já existe.',
          );
        }
      }

      int totalDeComprimidos = receita.item.medicamento.comprimidos * receita.item.quantidade;

      int comprimidosNecessarios = receita.frequencia * listaControle.duracaoTratamento;

      double caixasNecessarias = comprimidosNecessarios / receita.item.medicamento.comprimidos;

      if (totalDeComprimidos > comprimidosNecessarios) {
        throw ExceptionMessage(
          code: 'fora-limite',
          message: 'Esse medicamento só permite a dispensação de ${caixasNecessarias.toInt()} caixas para essa receita.',
        );
      }

      if (listaControle.tipoReceitaId != receita.tipoReceitaId) {
        throw ExceptionMessage(
          code: 'receita-inválida',
          message: 'Esse medicamento só permite a dispensação com receita do tipo ${listaControle.tipoReceita.nome}',
        );
      }
    }

    receita.item.preco = receita.item.medicamento.preco;

    receita.item.medicamento.quantidade -= receita.item.quantidade;

    await _serviceMedicamento.save(receita.item.medicamento);

    receita.dataDispensacao = DateTime.now();

    return super.save(receita);
  }

  @override
  Stream<List<Receita>> streamAll([IEntity? relatedEntity]) {
    return super.streamAll().asyncMap((receitas) async {
      receitas.sort((a, b) => a.dataDispensacao!.compareTo(b.dataDispensacao!));
      return await Future.wait(
        receitas.map((receita) async {
          return await _getRelatedData(receita);
        }),
      );
    });
  }
}
