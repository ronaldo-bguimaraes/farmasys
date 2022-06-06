import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/mask/interface/i_mask_telefone.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicoForm extends StatefulWidget {
  final String title;
  final Medico medico;
  final List<Especialidade> especialidades;

  const MedicoForm({Key? key, required this.medico, required this.title, required this.especialidades}) : super(key: key);

  @override
  State<MedicoForm> createState() => _MedicoFormState();
}

class _MedicoFormState extends State<MedicoForm> {
  final _formKey = GlobalKey<FormState>();

  final _crmUfController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      DropdownButtonFormField<String>(
                        value: widget.medico.especialidadeId,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Lista de Controle',
                        ),
                        items: widget.especialidades.map((e) {
                          return DropdownMenuItem<String>(
                            value: e.id,
                            child: Text(e.descricao),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            widget.medico.especialidadeId = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione uma lista de controle';
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
                              await context.read<IServiceMedico>().save(widget.medico);
                              Navigator.of(context).pop();
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
