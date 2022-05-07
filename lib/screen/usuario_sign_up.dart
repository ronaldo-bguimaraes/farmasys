import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/dto/service/user_service.dart';
import 'package:farmasys/repository/farmaceutico_repository_firebase.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UsuarioSignUp extends StatefulWidget {
  const UsuarioSignUp({Key? key}) : super(key: key);

  @override
  State<UsuarioSignUp> createState() => _UsuarioSignUpState();
}

class _UsuarioSignUpState extends State<UsuarioSignUp> {
  final _formKey = GlobalKey<FormState>();

  final _cpfController = TextEditingController();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  late final FarmaceuticoFirebaseRepository _repository;
  late final UserService<Farmaceutico> _service;

  @override
  void initState() {
    super.initState();
    _repository = FarmaceuticoFirebaseRepository();
    _service = UserService(_repository);
  }

  @override
  Widget build(BuildContext context) {
    // var phoneMask = MaskTextInputFormatter(mask: '(##) #####-####');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Nome'),
                TextFormField(
                  controller: _nomeController,
                ),
                const Text('CPF'),
                TextFormField(
                  controller: _cpfController,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '###.###.###-##'),
                  ],
                ),
                const Text('Email'),
                TextFormField(
                  controller: _emailController,
                ),
                const Text('Telefone'),
                TextFormField(
                  controller: _telefoneController,
                  inputFormatters: [
                    MaskTextInputFormatter(mask: '(##) #####-####'),
                  ],
                ),
                const Text('Senha'),
                TextFormField(
                  controller: _senhaController,
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
                const Text('Confirme a senha'),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'A senha não pode ser vazia';
                    }
                    if (value.length < 8) {
                      return 'A senha deve ter pelo menos 8 caracteres';
                    }
                    if (value != _senhaController.text) {
                      return 'As senhas não correspondem';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  child: const Text('Cadastrar Farmacêutico'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var farmaceutico = Farmaceutico(
                        nome: _nomeController.text,
                        cpf: _cpfController.text,
                        email: _emailController.text,
                        phone: _telefoneController.text,
                        senha: _senhaController.text,
                      );
                      _service.createUserWithEmailAndPassword(farmaceutico);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
