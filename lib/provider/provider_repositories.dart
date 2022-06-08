import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_venda.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_principio_ativo.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_venda.dart';
import 'package:farmasys/repository/firebase/firebase_repository_cliente.dart';
import 'package:farmasys/repository/firebase/firebase_repository_especialidade.dart';
import 'package:farmasys/repository/firebase/firebase_repository_farmaceutico.dart';
import 'package:farmasys/repository/firebase/firebase_repository_item_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_item_venda.dart';
import 'package:farmasys/repository/firebase/firebase_repository_lista_controle.dart';
import 'package:farmasys/repository/firebase/firebase_repository_medicamento.dart';
import 'package:farmasys/repository/firebase/firebase_repository_medico.dart';
import 'package:farmasys/repository/firebase/firebase_repository_notificacao.dart';
import 'package:farmasys/repository/firebase/firebase_repository_principio_ativo.dart';
import 'package:farmasys/repository/firebase/firebase_repository_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/firebase/firebase_repository_tipo_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_venda.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_item_receita.dart';
import 'package:farmasys/repository/interface/i_repository_item_venda.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/repository/interface/i_repository_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_principio_ativo.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:farmasys/repository/interface/i_repository_venda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provê todos os repositorios necessários
class ProviderRepositories extends StatelessWidget {
  final Widget child;

  const ProviderRepositories({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IRepositoryFarmaceutico>(
          create: (ctx) => FirebaseRepositoryFarmaceutico(
            ctx.read<IMapperFarmaceutico>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryMedico>(
          create: (ctx) => FirebaseRepositoryMedico(
            ctx.read<IMapperMedico>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryPrincipioAtivo>(
          create: (ctx) => FirebaseRepositoryPrincipioAtivo(
            ctx.read<IMapperPrincipioAtivo>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryMedicamento>(
          create: (ctx) => FirebaseRepositoryMedicamento(
            ctx.read<IMapperMedicamento>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryCliente>(
          create: (ctx) => FirebaseRepositoryCliente(
            ctx.read<IMapperCliente>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryTipoNotificacao>(
          create: (ctx) => FirebaseRepositoryTipoNotificacao(
            ctx.read<IMapperTipoNotificacao>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryTipoReceita>(
          create: (ctx) => FirebaseRepositoryTipoReceita(
            ctx.read<IMapperTipoReceita>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryListaControle>(
          create: (ctx) => FirebaseRepositoryListaControle(
            ctx.read<IMapperListaControle>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryEspecialidade>(
          create: (ctx) => FirebaseRepositoryEspecialidade(
            ctx.read<IMapperEspecialidade>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryVenda>(
          create: (ctx) => FirebaseRepositoryVenda(
            ctx.read<IMapperVenda>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryReceita>(
          create: (ctx) => FirebaseRepositoryReceita(
            ctx.read<IMapperReceita>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryItemVenda>(
          create: (ctx) => FirebaseRepositoryItemVenda(
            ctx.read<IMapperItemVenda>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryItemReceita>(
          create: (ctx) => FirebaseRepositoryItemReceita(
            ctx.read<IMapperItemReceita>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryNotificacao>(
          create: (ctx) => FirebaseRepositoryNotificacao(
            ctx.read<IMapperNotificacao>(),
          ),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
