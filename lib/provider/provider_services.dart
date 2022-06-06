import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/repository/interface/i_repository_substancia.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:farmasys/service/firebase/firebase_service_authentication_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_authentication_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_lista_especialidade.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:farmasys/service/interface/i_service_substancia.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/service_cliente.dart';
import 'package:farmasys/service/service_especialidade.dart';
import 'package:farmasys/service/service_farmaceutico.dart';
import 'package:farmasys/service/service_lista_controle.dart';
import 'package:farmasys/service/service_medicamento.dart';
import 'package:farmasys/service/service_medico.dart';
import 'package:farmasys/service/service_substancia.dart';
import 'package:farmasys/service/service_tipo_notificacao.dart';
import 'package:farmasys/service/service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provê todos serviços necessários
class ProviderServices extends StatelessWidget {
  final Widget child;

  const ProviderServices({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IServiceAuthenticationFarmaceutico>(
          create: (context) => ServiceFirebaseAuthenticationFarmaceutico(
            context.read<IRepositoryFarmaceutico>(),
          ),
          lazy: true,
        ),
        Provider<IServiceFarmaceutico>(
          create: (context) => ServiceFarmaceutico(
            context.read<IRepositoryFarmaceutico>(),
            context.read<IServiceAuthenticationFarmaceutico>(),
          ),
          lazy: true,
        ),
        Provider<IServiceMedico>(
          create: (context) => ServiceMedico(
            context.read<IRepositoryMedico>(),
            context.read<IRepositoryEspecialidade>(),
          ),
          lazy: true,
        ),
        Provider<IServiceSubstancia>(
          create: (context) => ServiceSubstancia(
            context.read<IRepositorySubstancia>(),
            context.read<IRepositoryListaControle>(),
          ),
          lazy: true,
        ),
        Provider<IServiceMedicamento>(
          create: (context) => ServiceMedicamento(
            context.read<IRepositoryMedicamento>(),
            context.read<IRepositorySubstancia>(),
          ),
          lazy: true,
        ),
        Provider<IServiceCliente>(
          create: (context) => ServiceCliente(
            context.read<IRepositoryCliente>(),
          ),
          lazy: true,
        ),
        Provider<IServiceTipoNotificacao>(
          create: (context) => ServiceTipoNotificacao(
            context.read<IRepositoryTipoNotificacao>(),
          ),
          lazy: true,
        ),
        Provider<IServiceTipoReceita>(
          create: (context) => ServiceTipoReceita(
            context.read<IRepositoryTipoReceita>(),
          ),
          lazy: true,
        ),
        Provider<IServiceListaControle>(
          create: (context) => ServiceListaControle(
            context.read<IRepositoryListaControle>(),
          ),
          lazy: true,
        ),
        Provider<IServiceEspecialidade>(
          create: (context) => ServiceEspecialidade(
            context.read<IRepositoryEspecialidade>(),
          ),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
