import 'package:easy_mask/easy_mask.dart';
import 'package:email_validator/email_validator.dart';
import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/repository/cliente_firebase_repository.dart';
import 'package:farmasys/screen/mask/cpf_mask.dart';
import 'package:farmasys/screen/mask/phone_mask.dart';
import 'package:farmasys/service/cliente_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClienteEdit extends StatefulWidget {
  static const String routeName = '/cliente-edit';

  final Cliente cliente;

  const ClienteEdit({Key? key, required this.cliente}) : super(key: key);

  @override
  State<ClienteEdit> createState() => _ClienteEditState();
}

class _ClienteEditState extends State<ClienteEdit> {
  final _formKey = GlobalKey<FormState>();

  late final IRepository<Cliente> _repository;
  late final ClienteService<Cliente> _service;

  final TextInputMask _cpfMask = getCpfMask();
  final TextInputMask _phoneMask = getPhoneMask();

  @override
  void initState() {
    super.initState();
    _repository = ClienteFirebaseRepository();
    _service = ClienteService(_repository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Cliente'),
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
                        initialValue: widget.cliente.nome,
                        onSaved: (value) {
                          if (value != null) {
                            widget.cliente.nome = value;
                          }
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
                        initialValue: widget.cliente.cpf,
                        onSaved: (value) {
                          if (value != null) {
                            widget.cliente.cpf = value;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CPF',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          _cpfMask,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O CPF não pode ser vazio';
                          }
                          if (value.length < 14) {
                            return 'CPF inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.cliente.telefone,
                        onSaved: (value) {
                          if (value != null) {
                            widget.cliente.telefone = value;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Telefone',
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          _phoneMask,
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
                        initialValue: widget.cliente.email,
                        onSaved: (value) {
                          if (value != null) {
                            widget.cliente.email = value;
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
                      ElevatedButton(
                        child: const Text('Salvar'),
                        onPressed: () async {
                          var state = _formKey.currentState;
                          if (state != null) {
                            state.save();
                          }
                          if (state != null && state.validate()) {
                            try {
                              await _service.update(widget.cliente);
                              Navigator.of(context).pop();
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
