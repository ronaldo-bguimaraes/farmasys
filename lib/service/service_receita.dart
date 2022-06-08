import 'package:farmasys/dto/inteface/i_entity.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:farmasys/service/service_entity_base.dart';
import 'package:intl/intl.dart';

class ServiceReceita extends ServiceEntityBase<Receita> implements IServiceReceita {
  // ignore: unused_field
  final IRepositoryReceita _repositoryReceita;

  ServiceReceita(this._repositoryReceita) : super(_repositoryReceita);

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Receita> save(Receita receita, [IEntity? relatedEntity]) async {
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
      final dataFinal = dataEmissao.add(
        Duration(
          days: listaControle.prazo,
        ),
      );

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

      if(listaControle.tipoReceitaId == receita.tipoReceitaId) {
        throw ExceptionMessage(
          code: 'receita-inválida',
          message: 'Esse medicamento só permite a dispensação com receita do tipo ${listaControle.tipoReceita.nome}',
        );
      }
    }

    receita.item.preco = receita.item.medicamento.preco;

    return super.save(receita);
  }
}
