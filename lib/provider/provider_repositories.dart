import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_substancia.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';
import 'package:farmasys/repository/firebase_repository_cliente.dart';
import 'package:farmasys/repository/firebase_repository_especialidade.dart';
import 'package:farmasys/repository/firebase_repository_farmaceutico.dart';
import 'package:farmasys/repository/firebase_repository_lista_controle.dart';
import 'package:farmasys/repository/firebase_repository_medicamento.dart';
import 'package:farmasys/repository/firebase_repository_medico.dart';
import 'package:farmasys/repository/firebase_repository_substancia.dart';
import 'package:farmasys/repository/firebase_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/firebase_repository_tipo_receita.dart';
import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/repository/interface/i_repository_substancia.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provê todos os repositorios necessários
class ProviderRepositories extends StatelessWidget {
  final Widget child;
  
  const ProviderRepositories({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IRepositoryFarmaceutico>(
          create: (context) => FirebaseRepositoryFarmaceutico(
            context.read<IMapperFarmaceutico>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryMedico>(
          create: (context) => FirebaseRepositoryMedico(
            context.read<IMapperMedico>(),
          ),
          lazy: true,
        ),
        Provider<IRepositorySubstancia>(
          create: (context) => FirebaseRepositorySubstancia(
            context.read<IMapperSubstancia>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryMedicamento>(
          create: (context) => FirebaseRepositoryMedicamento(
            context.read<IMapperMedicamento>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryCliente>(
          create: (context) => FirebaseRepositoryCliente(
            context.read<IMapperCliente>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryTipoNotificacao>(
          create: (context) => FirebaseRepositoryTipoNotificacao(
            context.read<IMapperTipoNotificacao>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryTipoReceita>(
          create: (context) => FirebaseRepositoryTipoReceita(
            context.read<IMapperTipoReceita>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryListaControle>(
          create: (context) => FirebaseRepositoryListaControle(
            context.read<IMapperListaControle>(),
          ),
          lazy: true,
        ),
        Provider<IRepositoryEspecialidade>(
          create: (context) => FirebaseRepositoryEspecialidade(
            context.read<IMapperEspecialidade>(),
          ),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
