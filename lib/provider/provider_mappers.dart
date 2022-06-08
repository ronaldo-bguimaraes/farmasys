import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_codigo.dart';
import 'package:farmasys/mapper/interface/i_mapper_crm.dart';
import 'package:farmasys/mapper/interface/i_mapper_endereco.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_item_venda.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_principio_ativo.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_venda.dart';
import 'package:farmasys/mapper/mapper_cliente.dart';
import 'package:farmasys/mapper/mapper_codigo.dart';
import 'package:farmasys/mapper/mapper_crm.dart';
import 'package:farmasys/mapper/mapper_endereco.dart';
import 'package:farmasys/mapper/mapper_especialidade.dart';
import 'package:farmasys/mapper/mapper_farmaceutico.dart';
import 'package:farmasys/mapper/mapper_item_receita.dart';
import 'package:farmasys/mapper/mapper_item_venda.dart';
import 'package:farmasys/mapper/mapper_lista_controle.dart';
import 'package:farmasys/mapper/mapper_medicamento.dart';
import 'package:farmasys/mapper/mapper_medico.dart';
import 'package:farmasys/mapper/mapper_notificacao.dart';
import 'package:farmasys/mapper/mapper_receita.dart';
import 'package:farmasys/mapper/mapper_principio_ativo.dart';
import 'package:farmasys/mapper/mapper_tipo_notificacao.dart';
import 'package:farmasys/mapper/mapper_tipo_receita.dart';
import 'package:farmasys/mapper/mapper_venda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provê todos os mapeadores necessários
class ProviderMappers extends StatelessWidget {
  final Widget child;
  
  const ProviderMappers({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IMapperCliente>(
          create: (ctx) => MapperCliente(),
          lazy: true,
        ),
        Provider<IMapperCodigo>(
          create: (ctx) => MapperCodigo(),
          lazy: true,
        ),
        Provider<IMapperCRM>(
          create: (ctx) => MapperCRM(),
          lazy: true,
        ),
        Provider<IMapperEndereco>(
          create: (ctx) => MapperEndereco(),
          lazy: true,
        ),
        Provider<IMapperFarmaceutico>(
          create: (ctx) => MapperFarmaceutico(),
          lazy: true,
        ),
        Provider<IMapperItemReceita>(
          create: (ctx) => MapperItemReceita(),
          lazy: true,
        ),
        Provider<IMapperListaControle>(
          create: (ctx) => MapperListaControle(),
          lazy: true,
        ),
        Provider<IMapperMedicamento>(
          create: (ctx) => MapperMedicamento(),
          lazy: true,
        ),
        Provider<IMapperMedico>(
          create: (ctx) => MapperMedico(
            ctx.read<IMapperCRM>(),
          ),
          lazy: true,
        ),
        Provider<IMapperNotificacao>(
          create: (ctx) => MapperNotificacao(),
          lazy: true,
        ),
        Provider<IMapperReceita>(
          create: (ctx) => MapperReceita(),
          lazy: true,
        ),
        Provider<IMapperPrincipioAtivo>(
          create: (ctx) => MapperPrincipioAtivo(),
          lazy: true,
        ),
        Provider<IMapperTipoNotificacao>(
          create: (ctx) => MapperTipoNotificacao(),
          lazy: true,
        ),
        Provider<IMapperTipoReceita>(
          create: (ctx) => MapperTipoReceita(),
          lazy: true,
        ),
        Provider<IMapperEspecialidade>(
          create: (ctx) => MapperEspecialidade(),
          lazy: true,
        ),
        Provider<IMapperReceita>(
          create: (ctx) => MapperReceita(),
          lazy: true,
        ),
        Provider<IMapperVenda>(
          create: (ctx) => MapperVenda(),
          lazy: true,
        ),
        Provider<IMapperItemReceita>(
          create: (ctx) => MapperItemReceita(),
          lazy: true,
        ),
        Provider<IMapperItemVenda>(
          create: (ctx) => MapperItemVenda(),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
