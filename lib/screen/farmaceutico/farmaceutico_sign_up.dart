import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/home/home.dart';
import 'package:farmasys/screen/mask/interface/i_mask_cpf.dart';
import 'package:farmasys/screen/mask/interface/i_mask_telefone.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmaceuticoSignUp extends StatefulWidget {
  static const String routeName = '/farmaceutico-sign-up';

  const FarmaceuticoSignUp({Key? key}) : super(key: key);

  @override
  State<FarmaceuticoSignUp> createState() => _FarmaceuticoSignUpState();
}

class _FarmaceuticoSignUpState extends State<FarmaceuticoSignUp> {
  final _formKey = GlobalKey<FormState>();

  final _farmaceutico = Farmaceutico();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie a sua conta'),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return FullScroll(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _farmaceutico.nome,
                      onChanged: (value) {
                        setState(() {
                          _farmaceutico.nome = value;
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
                      initialValue: _farmaceutico.cpf,
                      onChanged: (value) {
                        setState(() {
                          _farmaceutico.cpf = value;
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
                      initialValue: _farmaceutico.telefone,
                      onChanged: (value) {
                        setState(() {
                          _farmaceutico.telefone = value;
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
                      initialValue: _farmaceutico.email,
                      onChanged: (value) {
                        setState(() {
                          _farmaceutico.email = value;
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
                    TextFormField(
                      initialValue: _farmaceutico.senha,
                      onChanged: (value) {
                        setState(() {
                          _farmaceutico.senha = value;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A senha não pode ser vazia';
                        }
                        if (value.length < 8) {
                          return 'A senha deve ter pelo menos 8 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirme a Senha',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A senha não pode ser vazia';
                        }
                        if (value.length < 8) {
                          return 'A senha deve ter pelo menos 8 caracteres';
                        }
                        if (value != _farmaceutico.senha) {
                          return 'As senhas não correspondem';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      child: const Text('Cadastrar Farmacêutico'),
                      onPressed: () async {
                        final state = _formKey.currentState;
                        if (state != null && state.validate()) {
                          try {
                            await ctx.read<IServiceFarmaceutico>().signUp(_farmaceutico);
                            Home.show(ctx);
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
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
