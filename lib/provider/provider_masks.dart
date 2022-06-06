import 'package:farmasys/screen/mask/interface/i_mask_cpf.dart';
import 'package:farmasys/screen/mask/interface/i_mask_telefone.dart';
import 'package:farmasys/screen/mask/mask_cpf.dart';
import 'package:farmasys/screen/mask/mask_phone.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// provê todas as máscaras necessárias
class ProviderMasks extends StatelessWidget {
  final Widget child;

  const ProviderMasks({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IMaskCpf>(
          create: (context) => MaskCpf(),
          lazy: true,
        ),
        Provider<IMaskTelefone>(
          create: (context) => MaskTelefone(),
          lazy: true,
        ),
      ],
      child: child,
    );
  }
}
