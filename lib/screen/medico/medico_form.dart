import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/especialidade/especialidade_form.dart';
import 'package:farmasys/screen/helper/estados.dart';
import 'package:farmasys/screen/mask/interface/i_mask_telefone.dart';
import 'package:farmasys/service/interface/i_service_especialidade.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicoForm extends StatefulWidget {
  final String title;
  final Medico medico;
  final List<Especialidade> especialidades;

  const MedicoForm({
    Key? key,
    required this.medico,
    required this.title,
    required this.especialidades,
  }) : super(key: key);

  @override
  State<MedicoForm> createState() => _MedicoFormState();

  static Future<Medico?> show(BuildContext ctx, [Medico? medico]) async {
    return await Navigator.of(ctx).push<Medico?>(
      MaterialPageRoute(
        builder: (ctx) {
          return StreamSnapshotBuilder<List<Especialidade>>(
            stream: ctx.read<IServiceEspecialidade>().streamAll(),
            showChild: (especialidades) {
              return especialidades != null;
            },
            builder: (ctx, especialidades) {
              return MedicoForm(
                title: '${medico == null ? "Cadastrar" : "Editar"} médico',
                medico: medico ?? Medico(),
                especialidades: especialidades,
              );
            },
          );
        },
      ),
    );
  }
}

class _MedicoFormState extends State<MedicoForm> {
  final _formKey = GlobalKey<FormState>();
  late Medico _medico;
  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _medico = widget.medico;
    _codigoController.text = _medico.crm.codigo;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Médico'),
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
                      initialValue: _medico.nome,
                      onChanged: (value) {
                        setState(() {
                          _medico.nome = value.trim();
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
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _medico.especialidadeId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Especialidade',
                            ),
                            items: widget.especialidades.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text(e.nome, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _medico.especialidade = widget.especialidades.firstWhere((e) => e.id == value);
                                _medico.especialidadeId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione uma especialidade';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            final especialidade = await EspecialidadeForm.show(ctx);
                            if (especialidade != null) {
                              widget.especialidades.add(especialidade);
                              widget.especialidades.sort((a, b) => a.nome.compareTo(b.nome));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(
                              15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _medico.telefone,
                      onChanged: (value) {
                        setState(() {
                          _medico.telefone = value;
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
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _medico.crm.uf,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'UF',
                      ),
                      items: estados.keys.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text('${estados[e]} ($e)', overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _medico.crm.uf = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione uma unidade federativa';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _codigoController,
                      onChanged: (value) {
                        setState(() {
                          _medico.crm.codigo = value;
                        });
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
                        final state = _formKey.currentState;
                        if (state != null && state.validate()) {
                          try {
                            _medico = await ctx.read<IServiceMedico>().save(_medico);
                            //
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Médico salvo com sucesso.'),
                                duration: Duration(milliseconds: 1200),
                              ),
                            );
                            Navigator.of(ctx).pop(_medico);
                          }
                          //
                          on ExceptionMessage catch (error) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Erro: ${error.message}'),
                                duration: const Duration(milliseconds: 1200),
                              ),
                            );
                            Navigator.of(ctx).pop();
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
        },
      ),
    );
  }
}
