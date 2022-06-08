import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/mask/interface/i_mask_cpf.dart';
import 'package:farmasys/screen/mask/interface/i_mask_telefone.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClienteForm extends StatefulWidget {
  final String title;
  final Cliente cliente;

  const ClienteForm({
    Key? key,
    required this.cliente,
    required this.title,
  }) : super(key: key);

  @override
  State<ClienteForm> createState() => _ClienteFormState();

  static Future<Cliente?> show(BuildContext ctx, [Cliente? cliente]) async {
    return Navigator.of(ctx).push<Cliente?>(
      MaterialPageRoute(
        builder: (ctx) {
          return ClienteForm(
            title: '${cliente == null ? "Cadastrar" : "Editar"} cliente',
            cliente: cliente ?? Cliente(),
          );
        },
      ),
    );
  }
}

class _ClienteFormState extends State<ClienteForm> {
  final _formKey = GlobalKey<FormState>();

  late Cliente _cliente;

  @override
  void initState() {
    super.initState();
    _cliente = widget.cliente;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(builder: (ctx, constraints) {
        return FullScroll(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _cliente.nome,
                    onChanged: (value) {
                      setState(() {
                        _cliente.nome = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome não pode ser vazio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _cliente.cpf,
                    onChanged: (value) {
                      setState(() {
                        _cliente.cpf = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CPF',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      ctx.read<IMaskCpf>().inputMask,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O CPF não pode ser vazio';
                      }
                      if (CPFValidator.isValid(value) == false) {
                        return 'CPF inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _cliente.telefone,
                    onChanged: (value) {
                      setState(() {
                        _cliente.telefone = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      ctx.read<IMaskTelefone>().inputMask,
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O telefone não pode ser vazio';
                      }
                      if (value.length < 14) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: _cliente.email,
                    onChanged: (value) {
                      setState(() {
                        _cliente.email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O email não pode ser vazio';
                      }
                      if (EmailValidator.validate(value) == false) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    child: const Text('Salvar'),
                    onPressed: () async {
                      final state = _formKey.currentState;
                      if (state != null && state.validate()) {
                        try {
                          _cliente = await ctx.read<IServiceCliente>().save(_cliente);
                          //
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text('Cliente salvo com sucesso.'),
                              duration: Duration(milliseconds: 1200),
                            ),
                          );
                          Navigator.of(ctx).pop(_cliente);
                        }
                        //
                        on ExceptionMessage catch (error) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text('Erro: ${error.message}'),
                              duration: const Duration(milliseconds: 1200),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          ),
        );
      }),
    );
  }
}
