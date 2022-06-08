import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/helper/estados.dart';
import 'package:farmasys/screen/mask/interface/i_mask_date.dart';
import 'package:farmasys/screen/medicamento/medicamento_form.dart';
import 'package:farmasys/screen/medico/medico_form.dart';
import 'package:farmasys/screen/medico/medico_select.dart';
import 'package:farmasys/screen/tipo_notificacao/tipo_notificacao_form.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_form.dart';
import 'package:farmasys/service/interface/i_service_cliente.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceitaForm extends StatefulWidget {
  final String title;
  final Receita receita;
  final List<TipoReceita> tiposReceita;
  final List<Medicamento> medicamentos;
  final List<TipoNotificacao> tiposNotificacao;
  final List<Cliente> clientes;

  const ReceitaForm({
    Key? key,
    required this.tiposReceita,
    required this.tiposNotificacao,
    required this.clientes,
    required this.medicamentos,
    required this.receita,
    required this.title,
  }) : super(key: key);

  @override
  State<ReceitaForm> createState() => _ReceitaFormState();

  static void show(BuildContext ctx, [Receita? receita]) async {
    final List<TipoReceita> tiposReceita = await ctx.read<IServiceTipoReceita>().getAll();
    final List<Medicamento> medicamentos = await ctx.read<IServiceMedicamento>().getAll();
    final List<TipoNotificacao> tiposNotificacao = await ctx.read<IServiceTipoNotificacao>().getAll();
    final List<Cliente> clientes = await ctx.read<IServiceCliente>().getAll();

    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) {
          return ReceitaForm(
            title: '${receita == null ? "Cadastrar" : "Editar"} receita',
            receita: receita ?? Receita(),
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

class _ReceitaFormState extends State<ReceitaForm> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat('dd/MM/yyyy');

  late Receita _receita = Receita();

  final Notificacao _notificacao = Notificacao();

  List<TipoNotificacao> get _tiposNotificacao {
    return _receita.notificacao != null ? widget.tiposNotificacao : [];
  }

  Map<String, String> get _estados {
    return _receita.notificacao != null ? estados : {};
  }

  String get _dataEmissao {
    return _receita.dataEmissao != null ? _dateFormat.format(_receita.dataEmissao!) : '';
  }

  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _receita = widget.receita;
    _codigoController.text = _receita.notificacao?.codigo.codigo ?? '';
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
                      onChanged: (value) {
                        _receita.dataEmissao = _dateFormat.parse(value);
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
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: Text(
                                _receita.medico.nome == '' ? 'Clique para selecionar um médico' : _receita.medico.nome,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onTap: () async {
                              final medico = await MedicoSelect.show(ctx);
                              if (medico != null) {
                                setState(() {
                                  _receita.medico = medico;
                                  _receita.medicoId = medico.id;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            await MedicoForm.show(ctx);
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
                            value: _receita.tipoReceitaId,
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
                                _receita.tipoReceita = widget.tiposReceita.firstWhere((e) => e.id == value);
                                _receita.tipoReceitaId = value;
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
                              setState(() {
                                widget.tiposReceita.add(tipoReceita);
                                widget.tiposReceita.sort((a, b) => a.nome.compareTo(b.nome));
                              });
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
                    SwitchListTile(
                      title: const Text('Possui notificação de receita'),
                      value: _receita.notificacao != null,
                      onChanged: (value) {
                        setState(() {
                          _receita.notificacao = value ? _notificacao : null;
                          _codigoController.text = value ? _notificacao.codigo.codigo : '';
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _notificacao.codigo.uf,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'UF da notificação de receita',
                        enabled: _receita.notificacao != null,
                      ),
                      items: _estados.keys.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text('${_estados[e]} ($e)', overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _notificacao.codigo.uf = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null && _receita.notificacao != null) {
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
                          _notificacao.codigo.codigo = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Código da notificação de receita',
                        enabled: _receita.notificacao != null,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_receita.notificacao == null) {
                          return null;
                        }
                        if (value == null || value.isEmpty) {
                          return 'O código não pode ser vazio';
                        }
                        return null;
                      },
                      maxLength: 10,
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
                              labelText: 'Tipo de notificação',
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Medicamento',
                            ),
                            items: widget.medicamentos.map((e) {
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text('${e.nome} ${e.miligramas} mg', overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _receita.item.medicamento = widget.medicamentos.firstWhere((e) => e.id == value);
                              _receita.item.medicamentoId = value;
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
                          onPressed: () async {
                            final medicamento = await MedicamentoForm.show(ctx);
                            if (medicamento != null) {
                              widget.medicamentos.add(medicamento);
                              widget.medicamentos.sort((a, b) => a.nome.compareTo(b.nome));
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
                      initialValue: _receita.item.quantidade.toString(),
                      onChanged: (value) {
                        setState(() {
                          _receita.item.quantidade = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantidade de medicamentos (caixas)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A quantidade de medicamentos não pode ser vazia';
                        }
                        int? quantidade = int.tryParse(value);
                        //
                        if (quantidade == null || quantidade < 1) {
                          return 'Quantidade de medicamentos inválida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _receita.frequencia.toString(),
                      onChanged: (value) {
                        setState(() {
                          _receita.frequencia = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Frequência de consumo (por dia)',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A frequência de consumo não pode ser vazia';
                        }
                        int? frequencia = int.tryParse(value);
                        //
                        if (frequencia == null || frequencia < 1) {
                          return 'Frequência de consumo inválida';
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
                            // Navigator.of(ctx).pop();
                          }
                          //
                          on ExceptionMessage catch (error) {
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              SnackBar(
                                content: Text('Erro: ${error.message}'),
                                duration: const Duration(milliseconds: 1500),
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
