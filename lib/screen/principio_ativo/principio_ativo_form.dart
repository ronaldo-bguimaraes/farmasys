import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/builder/stream_snapshot_builder.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/lista_controle/lista_controle_form.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/interface/i_service_principio_ativo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrincipioAtivoForm extends StatefulWidget {
  final String title;
  final PrincipioAtivo principioAtivo;
  final List<ListaControle> listasControle;

  const PrincipioAtivoForm({Key? key, required this.principioAtivo, required this.listasControle, required this.title}) : super(key: key);

  @override
  State<PrincipioAtivoForm> createState() => _PrincipioAtivoFormState();

  static Future<PrincipioAtivo?> show(BuildContext ctx, [PrincipioAtivo? principioAtivo]) async {
    return Navigator.of(ctx).push<PrincipioAtivo?>(
      MaterialPageRoute(builder: (ctx) {
        return StreamSnapshotBuilder<List<ListaControle>>(
          stream: ctx.read<IServiceListaControle>().streamAll(),
          showChild: (listasControle) {
            return listasControle != null;
          },
          builder: (ctx, listasControle) {
            return PrincipioAtivoForm(
              title: '${principioAtivo == null ? "Cadastrar" : "Editar"} principio ativo',
              principioAtivo: principioAtivo ?? PrincipioAtivo(),
              listasControle: listasControle,
            );
          },
        );
      }),
    );
  }
}

class _PrincipioAtivoFormState extends State<PrincipioAtivoForm> {
  final _formKey = GlobalKey<FormState>();

  late PrincipioAtivo _principioAtivo;
  final _nomeController = TextEditingController();

  late bool _possuiListaControle;

  List<ListaControle> get _listasControle {
    return _possuiListaControle ? widget.listasControle : [];
  }

  @override
  void initState() {
    super.initState();
    _principioAtivo = widget.principioAtivo;
    _nomeController.text = _principioAtivo.nome;
    _possuiListaControle = _principioAtivo.listaControleId != null;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      controller: _nomeController,
                      onChanged: (value) {
                        _nomeController.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: _nomeController.selection,
                        );
                        setState(() {
                          _principioAtivo.nome = value.trim().toUpperCase();
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.text,
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
                    SwitchListTile(
                      title: const Text('Possui lista de controle'),
                      value: _possuiListaControle,
                      onChanged: (value) {
                        setState(() {
                          _possuiListaControle = value;
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _principioAtivo.listaControleId,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Lista de controle',
                              enabled: _possuiListaControle,
                            ),
                            items: _listasControle.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text('${e.nome}  - ${e.tipoNotificacao != null ? "Notificação ${e.tipoNotificacao?.nome}" : "Sem notificação"}', overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _principioAtivo.listaControle = _listasControle.firstWhere((e) => e.id == value);
                                _principioAtivo.listaControleId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null && _possuiListaControle) {
                                return 'Selecione uma lista de controle';
                              }
                              return null;
                            },
                            isDense: true,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            final listaControle = await ListaControleForm.show(ctx);
                            if (listaControle != null) {
                              widget.listasControle.add(listaControle);
                              widget.listasControle.sort((a, b) => a.nome.compareTo(b.nome));
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
                    ElevatedButton(
                      child: const Text('Salvar'),
                      onPressed: () async {
                        final state = _formKey.currentState;
                        if (state != null && state.validate()) {
                          try {
                            _principioAtivo = await ctx.read<IServicePrincipioAtivo>().save(_principioAtivo);
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Princípio ativo salvo com sucesso.'),
                                duration: Duration(milliseconds: 1200),
                              ),
                            );
                            Navigator.of(ctx).pop(_principioAtivo);
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
        },
      ),
    );
  }
}
