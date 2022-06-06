import 'package:email_validator/email_validator.dart';
import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/home/home.dart';
import 'package:farmasys/screen/farmaceutico/farmaceutico_sign_up.dart';
import 'package:farmasys/service/interface/i_service_farmaceutico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmaceuticoSignIn extends StatefulWidget {
  static const String routeName = '/farmaceutico-sign-in';

  const FarmaceuticoSignIn({Key? key}) : super(key: key);

  @override
  State<FarmaceuticoSignIn> createState() => _FarmaceuticoSignInState();
}

class _FarmaceuticoSignInState extends State<FarmaceuticoSignIn> {
  final _formKey = GlobalKey<FormState>();

  final _farmaceutico = Farmaceutico(
    email: 'teste@teste.com',
    senha: '12345678',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Icon(
                Icons.local_hospital,
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'FarmaSys',
                style: TextStyle(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
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
              ElevatedButton(
                child: const Text('Entrar como Farmacêutico'),
                onPressed: () async {
                  var state = _formKey.currentState;
                  if (state != null) {
                    state.save();
                  }
                  if (state != null && state.validate()) {
                    try {
                      await context.read<IServiceFarmaceutico>().signIn(_farmaceutico);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        Home.routeName,
                        (_) => false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login realizado com sucesso!'),
                          duration: Duration(seconds: 1),
                        ),
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
              const SizedBox(
                height: 15,
              ),
              TextButton(
                child: const Text('Crie uma conta'),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    FarmaceuticoSignUp.routeName,
                  );
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
