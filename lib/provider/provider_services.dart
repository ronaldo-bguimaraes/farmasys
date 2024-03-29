import 'package:farmasys/repository/interface/i_repository_cliente.dart';
import 'package:farmasys/repository/interface/i_repository_especialidade.dart';
import 'package:farmasys/repository/interface/i_repository_farmaceutico.dart';
import 'package:farmasys/repository/interface/i_repository_lista_controle.dart';
import 'package:farmasys/repository/interface/i_repository_medicamento.dart';
import 'package:farmasys/repository/interface/i_repository_medico.dart';
import 'package:farmasys/repository/interface/i_repository_principio_ativo.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_receita.dart';
import 'package:farmasys/service/firebase/firebase_service_authentication_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_authentication_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_especialidade.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:farmasys/service/interface/i_service_principio_ativo.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/service_cliente.dart';
import 'package:farmasys/service/service_especialidade.dart';
import 'package:farmasys/service/service_farmaceutico.dart';
import 'package:farmasys/service/service_lista_controle.dart';
import 'package:farmasys/service/service_medicamento.dart';
import 'package:farmasys/service/service_medico.dart';
import 'package:farmasys/service/service_principio_ativo.dart';
import 'package:farmasys/service/service_receita.dart';
import 'package:farmasys/service/service_tipo_notificacao.dart';
import 'package:farmasys/service/service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provê todos serviços necessários
class ProviderServices extends StatelessWidget {
  final Widget child;

  const ProviderServices({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IServiceAuthenticationFarmaceutico>(
          create: (ctx) => ServiceFirebaseAuthenticationFarmaceutico(
            ctx.read<IRepositoryFarmaceutico>(),
          ),
          lazy: true,
        ),
        Provider<IServiceFarmaceutico>(
          create: (ctx) => ServiceFarmaceutico(
            ctx.read<IRepositoryFarmaceutico>(),
            ctx.read<IServiceAuthenticationFarmaceutico>(),
          ),
          lazy: true,
        ),
        Provider<IServiceMedico>(
          create: (ctx) => ServiceMedico(
            ctx.read<IRepositoryMedico>(),
            ctx.read<IRepositoryEspecialidade>(),
            ctx.read<IRepositoryReceita>(),
          ),
          lazy: true,
        ),
        Provider<IServiceListaControle>(
          create: (ctx) => ServiceListaControle(
            ctx.read<IRepositoryListaControle>(),
            ctx.read<IRepositoryTipoReceita>(),
            ctx.read<IRepositoryTipoNotificacao>(),
            ctx.read<IRepositoryPrincipioAtivo>(),
          ),
          lazy: true,
        ),
        Provider<IServicePrincipioAtivo>(
          create: (ctx) => ServicePrincipioAtivo(
            ctx.read<IRepositoryPrincipioAtivo>(),
            ctx.read<IServiceListaControle>(),
            ctx.read<IRepositoryMedicamento>(),
          ),
          lazy: true,
        ),
        Provider<IServiceMedicamento>(
          create: (ctx) => ServiceMedicamento(
            ctx.read<IRepositoryMedicamento>(),
            ctx.read<IServicePrincipioAtivo>(),
            ctx.read<IRepositoryReceita>(),
          ),
          lazy: true,
        ),
        Provider<IServiceCliente>(
          create: (ctx) => ServiceCliente(
            ctx.read<IRepositoryCliente>(),
            ctx.read<IRepositoryReceita>(),
          ),
          lazy: true,
        ),
        Provider<IServiceTipoNotificacao>(
          create: (ctx) => ServiceTipoNotificacao(
            ctx.read<IRepositoryTipoNotificacao>(),
            ctx.read<IRepositoryListaControle>(),
            ctx.read<IRepositoryReceita>(),
          ),
          lazy: true,
        ),
        Provider<IServiceTipoReceita>(
          create: (ctx) => ServiceTipoReceita(
            ctx.read<IRepositoryTipoReceita>(),
            ctx.read<IRepositoryListaControle>(),
            ctx.read<IRepositoryReceita>(),
          ),
          lazy: true,
        ),
        Provider<IServiceEspecialidade>(
          create: (ctx) => ServiceEspecialidade(
            ctx.read<IRepositoryEspecialidade>(),
            ctx.read<IRepositoryMedico>(),
          ),
          lazy: true,
        ),
        Provider<IServiceReceita>(
          create: (ctx) => ServiceReceita(
            ctx.read<IRepositoryReceita>(),
            ctx.read<IRepositoryMedico>(),
            ctx.read<IRepositoryCliente>(),
            ctx.read<IRepositoryFarmaceutico>(),
            ctx.read<IServiceMedicamento>(),
            ctx.read<IServiceTipoNotificacao>(),
            ctx.read<IServiceTipoReceita>(),
          ),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
