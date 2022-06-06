import 'package:farmasys/mapper/interface/i_mapper_cliente.dart';
import 'package:farmasys/mapper/interface/i_mapper_codigo.dart';
import 'package:farmasys/mapper/interface/i_mapper_crm.dart';
import 'package:farmasys/mapper/interface/i_mapper_endereco.dart';
import 'package:farmasys/mapper/interface/i_mapper_especialidade.dart';
import 'package:farmasys/mapper/interface/i_mapper_farmaceutico.dart';
import 'package:farmasys/mapper/interface/i_mapper_item.dart';
import 'package:farmasys/mapper/interface/i_mapper_lista_controle.dart';
import 'package:farmasys/mapper/interface/i_mapper_medicamento.dart';
import 'package:farmasys/mapper/interface/i_mapper_medico.dart';
import 'package:farmasys/mapper/interface/i_mapper_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';
import 'package:farmasys/mapper/interface/i_mapper_substancia.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_receita.dart';
import 'package:farmasys/mapper/mapper_cliente.dart';
import 'package:farmasys/mapper/mapper_codigo.dart';
import 'package:farmasys/mapper/mapper_crm.dart';
import 'package:farmasys/mapper/mapper_endereco.dart';
import 'package:farmasys/mapper/mapper_especialidade.dart';
import 'package:farmasys/mapper/mapper_farmaceutico.dart';
import 'package:farmasys/mapper/mapper_item.dart';
import 'package:farmasys/mapper/mapper_lista_controle.dart';
import 'package:farmasys/mapper/mapper_medicamento.dart';
import 'package:farmasys/mapper/mapper_medico.dart';
import 'package:farmasys/mapper/mapper_notificacao.dart';
import 'package:farmasys/mapper/mapper_receita.dart';
import 'package:farmasys/mapper/mapper_substancia.dart';
import 'package:farmasys/mapper/mapper_tipo_notificacao.dart';
import 'package:farmasys/mapper/mapper_tipo_receita.dart';
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
          create: (context) => MapperCliente(),
          lazy: true,
        ),
        Provider<IMapperCodigo>(
          create: (context) => MapperCodigo(),
          lazy: true,
        ),
        Provider<IMapperCRM>(
          create: (context) => MapperCRM(),
          lazy: true,
        ),
        Provider<IMapperEndereco>(
          create: (context) => MapperEndereco(),
          lazy: true,
        ),
        Provider<IMapperFarmaceutico>(
          create: (context) => MapperFarmaceutico(),
          lazy: true,
        ),
        Provider<IMapperItem>(
          create: (context) => MapperItem(),
          lazy: true,
        ),
        Provider<IMapperListaControle>(
          create: (context) => MapperListaControle(),
          lazy: true,
        ),
        Provider<IMapperMedicamento>(
          create: (context) => MapperMedicamento(),
          lazy: true,
        ),
        Provider<IMapperMedico>(
          create: (context) => MapperMedico(
            context.read<IMapperCRM>(),
          ),
          lazy: true,
        ),
        Provider<IMapperNotificacao>(
          create: (context) => MapperNotificacao(),
          lazy: true,
        ),
        Provider<IMapperReceita>(
          create: (context) => MapperReceita(),
          lazy: true,
        ),
        Provider<IMapperSubstancia>(
          create: (context) => MapperSubstancia(),
          lazy: true,
        ),
        Provider<IMapperTipoNotificacao>(
          create: (context) => MapperTipoNotificacao(),
          lazy: true,
        ),
        Provider<IMapperTipoReceita>(
          create: (context) => MapperTipoReceita(),
          lazy: true,
        ),
        Provider<IMapperEspecialidade>(
          create: (context) => MapperEspecialidade(),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
