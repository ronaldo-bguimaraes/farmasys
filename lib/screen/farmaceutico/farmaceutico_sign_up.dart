import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/exception/exception_message.dart';
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

  final _farmaceutico = Farmaceutico(
    email: '',
    senha: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crie a sua conta'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _farmaceutico.nome,
                        onSaved: (value) {
                          _farmaceutico.nome = value;
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
                        onSaved: (value) {
                          _farmaceutico.cpf = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CPF',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          context.read<IMaskCpf>().inputMask,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O CPF não pode ser vazio';
                          }
                          if (CPFValidator.isValid(value)) {
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
                        onSaved: (value) {
                          _farmaceutico.telefone = value;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Telefone',
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          context.read<IMaskTelefone>().inputMask,
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
                        onSaved: (value) {
                          if (value != null) {
                            _farmaceutico.email = value;
                          }
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
                        onSaved: (value) {
                          _farmaceutico.senha = value;
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
                          var state = _formKey.currentState;
                          if (state != null) {
                            state.save();
                          }
                          if (state != null && state.validate()) {
                            try {
                              await context.read<IServiceFarmaceutico>().signUp(_farmaceutico);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                Home.routeName,
                                (_) => false,
                              );
                            }
                            //
                            on ExceptionMessage catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error.message),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                              Navigator.of(context).pop();
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
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}
