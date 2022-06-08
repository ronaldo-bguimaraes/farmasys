import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/tipo_notificacao/tipo_notificacao_form.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_form.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaControleForm extends StatefulWidget {
  final String title;
  final ListaControle listaControle;
  final List<TipoReceita> tiposReceita;
  final List<TipoNotificacao> tiposNotificacao;

  const ListaControleForm({
    Key? key,
    required this.listaControle,
    required this.title,
    required this.tiposReceita,
    required this.tiposNotificacao,
  }) : super(key: key);

  @override
  State<ListaControleForm> createState() => _ListaControleFormState();

  static Future<ListaControle?> show(BuildContext ctx, [ListaControle? listaControle]) async {
    final tiposReceita = await ctx.read<IServiceTipoReceita>().getAll();
    final tiposNotificacao = await ctx.read<IServiceTipoNotificacao>().getAll();
    return Navigator.of(ctx).push<ListaControle?>(
      MaterialPageRoute(
        builder: (ctx) {
          return ListaControleForm(
            title: '${listaControle == null ? "Cadastrar" : "Editar"} lista de controle',
            listaControle: listaControle ?? ListaControle(),
            tiposReceita: tiposReceita,
            tiposNotificacao: tiposNotificacao,
          );
        },
      ),
    );
  }
}

class _ListaControleFormState extends State<ListaControleForm> {
  final _formKey = GlobalKey<FormState>();

  late ListaControle _listaControle;
  final _nomeController = TextEditingController();

  late bool _possuiNotificacao;

  List<TipoNotificacao> get _tiposNotificacao {
    return _possuiNotificacao ? widget.tiposNotificacao : [];
  }

  @override
  void initState() {
    super.initState();
    _listaControle = widget.listaControle;
    _nomeController.text = _listaControle.nome;
    _possuiNotificacao = _listaControle.tipoNotificacao?.id != null;
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
                          _listaControle.nome = value;
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
                    TextFormField(
                      initialValue: _listaControle.duracaoTratamento.toString(),
                      onChanged: (value) {
                        setState(() {
                          _listaControle.duracaoTratamento = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Duração de tratamento (em dias)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A duração de tratamento não pode ser vazia';
                        }
                        int? duracaoTratamento = int.tryParse(value);
                        //
                        if (duracaoTratamento == null || duracaoTratamento < 0) {
                          return 'Duração de tratamento inválida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _listaControle.prazo.toString(),
                      onChanged: (value) {
                        setState(() {
                          _listaControle.prazo = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Prazo de validade da receita (em dias)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A validade não pode ser vazia';
                        }
                        int? prazo = int.tryParse(value);
                        //
                        if (prazo == null || prazo < 0) {
                          return 'Prazo de validade da receita inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SwitchListTile(
                      title: const Text('Exige notificação de receita'),
                      value: _possuiNotificacao,
                      onChanged: (value) {
                        setState(() {
                          _possuiNotificacao = value;
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
                            value: _listaControle.tipoNotificacaoId,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Lista de tipos de notificação',
                              enabled: _possuiNotificacao,
                            ),
                            items: _tiposNotificacao.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: e.cor.value,
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(e.nome, overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _listaControle.tipoNotificacao = _tiposNotificacao.firstWhere((e) => e.id == value);
                                _listaControle.tipoNotificacaoId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null && _possuiNotificacao) {
                                return 'Selecione um tipo de notificação';
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
                            final tipoNotificacao = await TipoNotificacaoForm.show(ctx);
                            if (tipoNotificacao != null) {
                              widget.tiposNotificacao.add(tipoNotificacao);
                              widget.tiposNotificacao.sort((a, b) => a.nome.compareTo(b.nome));
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
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _listaControle.tipoReceitaId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Lista de tipos de receita',
                            ),
                            items: widget.tiposReceita.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text(e.nome, overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _listaControle.tipoReceitaId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione um tipo de receita';
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
                            final tipoReceita = await TipoReceitaForm.show(ctx);
                            if (tipoReceita != null) {
                              widget.tiposReceita.add(tipoReceita);
                              widget.tiposReceita.sort((a, b) => a.nome.compareTo(b.nome));
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
                          if (!_possuiNotificacao) {
                            _listaControle.tipoNotificacaoId = null;
                          }
                          try {
                            _listaControle = await ctx.read<IServiceListaControle>().save(_listaControle);
                            //
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Lista de controle salva com sucesso.'),
                                duration: Duration(milliseconds: 1200),
                              ),
                            );
                            Navigator.of(ctx).pop(_listaControle);
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
