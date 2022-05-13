import 'package:email_validator/email_validator.dart';
import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/farmaceutico_firebase_repository.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/screen/home/home.dart';
import 'package:farmasys/screen/user/user_sign_up.dart';
import 'package:farmasys/service/authenticator_firebase.dart';
import 'package:farmasys/service/interface/authentication_service.dart';
import 'package:farmasys/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSignIn extends StatefulWidget {
  static const String routeName = '/user-sign-in';

  const UserSignIn({Key? key}) : super(key: key);

  @override
  State<UserSignIn> createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  final _formKey = GlobalKey<FormState>();

  final _farmaceutico = Farmaceutico(
    email: 'teste@teste.com',
    senha: '12345678',
  );

  late final IRepository<Farmaceutico> _repository;
  late final IAuthenticator<Farmaceutico> _auth;
  late final UserServiceFirebase<Farmaceutico> _service;

  @override
  void initState() {
    super.initState();
    _repository = FarmaceuticoFirebaseRepository();
    _auth = FirebaseAuthenticator(_repository);
    _service = UserServiceFirebase(_auth);
  }

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
                      await _service.signIn(_farmaceutico);
                      Navigator.of(context).pushReplacementNamed(
                        Home.routeName,
                      );
                    }
                    //
                    on FirebaseAuthException catch (error) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Erro'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('${error.message}'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Ok'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    // catch end
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
                    UserSignUp.routeName,
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
