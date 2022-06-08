import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/item_receita.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/mask/interface/i_mask_date.dart';
import 'package:farmasys/screen/principio_ativo/principio_ativo_form.dart';
import 'package:farmasys/screen/tipo_notificacao/tipo_notificacao_form.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_medico.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceitaAdd extends StatefulWidget {
  final Receita receita;
  final List<Medico> medicos;
  final List<TipoReceita> tiposReceita;
  final List<Medicamento> medicamentos;
  final List<TipoNotificacao> tiposNotificacao;
  final List<Cliente> clientes;

  const ReceitaAdd({Key? key, required this.tiposReceita, required this.tiposNotificacao, required this.medicos, required this.clientes, required this.medicamentos, required this.receita})
      : super(key: key);

  @override
  State<ReceitaAdd> createState() => _ReceitaAddState();

  static void show(BuildContext ctx, [Receita? receita]) async {
    final List<Medico> medicos = await ctx.read<IServiceMedico>().getAll();
    final List<TipoReceita> tiposReceita = await ctx.read<IServiceTipoReceita>().getAll();
    final List<Medicamento> medicamentos = await ctx.read<IServiceMedicamento>().getAll();
    final List<TipoNotificacao> tiposNotificacao = await ctx.read<IServiceTipoNotificacao>().getAll();
    final List<Cliente> clientes = await ctx.read<IServiceCliente>().getAll();

    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) {
          return ReceitaAdd(
            receita: receita ?? Receita(),
            medicos: medicos,
            tiposReceita: tiposReceita,
            medicamentos: medicamentos,
            tiposNotificacao: tiposNotificacao,
            clientes: clientes,
          );
        },
      ),
    );
  }
}

class _ReceitaAddState extends State<ReceitaAdd> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat('dd/MM/yyyy');

  final Receita _receita = Receita();

  List<TipoNotificacao> get _tiposNotificacao {
    return _receita.notificacao != null ? widget.tiposNotificacao : [];
  }

  String get _dataEmissao {
    return _receita.dataEmissao != null ? _dateFormat.format(_receita.dataEmissao!) : '';
  }

  @override
  void initState() {
    super.initState();
    if (_receita.itens?.isEmpty ?? false) {
      _receita.itens?.add(ItemReceita());
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receita Add'),
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
                      initialValue: _dataEmissao,
                      onSaved: (value) {
                        _receita.dataEmissao = _dateFormat.parse(value!);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Data de emissão',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        ctx.read<IMaskDate>().inputMask,
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A data de emissão não pode ser vazia';
                        }
                        if (value.length < 10) {
                          return 'Data de emissão inválida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SwitchListTile(
                      title: const Text('Possui notificação de receita'),
                      value: _receita.notificacao != null,
                      onChanged: (value) {
                        setState(() {
                          _receita.notificacao = Notificacao();
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
                            value: _receita.notificacao?.tipoNotificacaoId,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Lista de tipos de notificação',
                              enabled: _receita.notificacao != null,
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
                                _receita.notificacao?.tipoNotificacaoId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null && _receita.notificacao != null) {
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
                          onPressed: () {
                            TipoNotificacaoForm.show(ctx);
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Medicamentos',
                            ),
                            items: widget.medicamentos.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text('${e.nome} ${e.miligramas} mg', overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _receita.itens?[0].medicamento = widget.medicamentos.firstWhere((e) => e.id == value);
                              _receita.itens?[0].medicamentoId = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione um medicamento';
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
                          onPressed: () {
                            PrincipioAtivoForm.show(ctx);
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
                      initialValue: _receita.itens?[0].quantidade.toString(),
                      onChanged: (value) {
                        setState(() {
                          _receita.itens?[0].quantidade = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantidade',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A quantidade não pode ser vazia';
                        }
                        int? quantidade = int.tryParse(value);
                        //
                        if (quantidade == null || quantidade < 0) {
                          return 'Quantidade inválida';
                        }
                        return null;
                      },
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // TextFormField(
                    //   initialValue: _receita.comprimidos.toString(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _receita.comprimidos = int.tryParse(value) ?? 0;
                    //     });
                    //   },
                    //   decoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Quantidade de comprimidos por caixa',
                    //   ),
                    //   keyboardType: TextInputType.number,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'A quantidade de comprimidos não pode ser vazia';
                    //     }
                    //     int? comprimidos = int.tryParse(value);
                    //     //
                    //     if (comprimidos == null || comprimidos < 0) {
                    //       return 'Quantidade de comprimidos inválida';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // TextFormField(
                    //   initialValue: _receita.quantidade.toString(),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _receita.quantidade = int.tryParse(value) ?? 0;
                    //     });
                    //   },
                    //   decoration: const InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Quantidade disponível',
                    //   ),
                    //   keyboardType: TextInputType.number,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'A quantidade disponível não pode ser vazia';
                    //     }
                    //     int? quantidade = int.tryParse(value);
                    //     //
                    //     if (quantidade == null || quantidade < 0) {
                    //       return 'Quantidade disponível inválida';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    ElevatedButton(
                      child: const Text('Salvar'),
                      onPressed: () async {
                        final state = _formKey.currentState;
                        if (state != null && state.validate()) {
                          try {
                            await ctx.read<IServiceReceita>().save(_receita);
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Receita salva com sucesso.'),
                                duration: Duration(milliseconds: 1200),
                              ),
                            );
                            Navigator.of(ctx).pop();
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
