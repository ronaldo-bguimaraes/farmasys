import 'package:easy_mask/easy_mask.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/repository/medico_firebase_repository.dart';
import 'package:farmasys/screen/mask/phone_mask.dart';
import 'package:farmasys/service/medico_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicoEdit extends StatefulWidget {
  static const String routeName = '/medico-edit';

  final Medico medico;

  const MedicoEdit({Key? key, required this.medico}) : super(key: key);

  @override
  State<MedicoEdit> createState() => _MedicoEditState();
}

class _MedicoEditState extends State<MedicoEdit> {
  final _formKey = GlobalKey<FormState>();

  late final IRepository<Medico> _repository;
  late final MedicoService<Medico> _service;

  late final TextInputMask _phoneMask = getPhoneMask();

  final _especialidadeController = TextEditingController();
  final _crmUfController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _repository = MedicoFirebaseRepository();
    _service = MedicoService(_repository);

    _especialidadeController.text = widget.medico.especialidade;
    _crmUfController.text = widget.medico.crm.uf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Médico'),
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
                        initialValue: widget.medico.nome,
                        onSaved: (value) {
                          if (value != null) {
                            widget.medico.nome = value;
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
                        controller: _especialidadeController,
                        onChanged: (value) {
                          _especialidadeController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: _especialidadeController.selection,
                          );
                        },
                        onSaved: (value) {
                          if (value != null) {
                            widget.medico.especialidade = value;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Especialidade',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A especialidade não pode ser vazia';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.medico.telefone,
                        onSaved: (value) {
                          if (value != null) {
                            widget.medico.telefone = value;
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
                        controller: _crmUfController,
                        onChanged: (value) {
                          _crmUfController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: _crmUfController.selection,
                          );
                        },
                        onSaved: (value) {
                          if (value != null) {
                            widget.medico.crm.uf = value;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'UF',
                        ),
                        keyboardType: TextInputType.text,
                        maxLength: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A UF não pode ser vazia';
                          }
                          if (value.length < 2) {
                            return 'A UF precisa ter 2 caracters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.medico.crm.codigo,
                        onSaved: (value) {
                          if (value != null) {
                            widget.medico.crm.codigo = value;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Código CRM',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O Código do CRM não pode ser vazio';
                          }
                          if (value.length < 4) {
                            return 'O Código do CRM precisa ter no mínimo 4 digitos';
                          }
                          return null;
                        },
                        maxLength: 10,
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
                              await _service.update(widget.medico);
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