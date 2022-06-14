import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/helper/estados.dart';
import 'package:farmasys/service/interface/i_service_authentication_farmaceutico.dart';
import 'package:farmasys/service/interface/i_service_receita.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReceitaView extends StatefulWidget {
  final String title;
  final Receita receita;

  const ReceitaView({
    Key? key,
    required this.receita,
    required this.title,
  }) : super(key: key);

  @override
  State<ReceitaView> createState() => _ReceitaViewState();

  static void show(BuildContext ctx, [Receita? receita]) async {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (ctx) {
          return ReceitaView(
            title: 'Visualizar receita',
            receita: receita ?? Receita(),
          );
        },
      ),
    );
  }
}

class _ReceitaViewState extends State<ReceitaView> {
  final _formKey = GlobalKey<FormState>();

  final _dateFormat = DateFormat('dd/MM/yyyy');

  late Receita _receita;

    Map<String, String> get _estados {
    return _receita.notificacao != null ? estados : {};
  }

  String get _dataEmissao {
    return _receita.dataEmissao != null ? _dateFormat.format(_receita.dataEmissao!) : '';
  }

  String get _dataDispensacao {
    return _receita.dataDispensacao != null ? _dateFormat.format(_receita.dataDispensacao!) : '';
  }

  String get _total {
    return 'R\$ ${_receita.item.medicamento.preco * _receita.item.quantidade}';
  }

  final _medicoController = TextEditingController();

  final _clienteController = TextEditingController();

  final _codigoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _receita = widget.receita;
    _codigoController.text = _receita.notificacao?.codigo.codigo ?? '';
    _receita.farmaceuticoId = context.read<IServiceAuthenticationFarmaceutico>().currentUser?.id;
    //
    _medicoController.text = _receita.medico.nome;
    _clienteController.text = _receita.cliente.nome;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar receita'),
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: _dataEmissao,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Data de emissão',
                            ),
                            enabled: false,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _dataDispensacao,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Data de dispensação',
                            ),
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _medicoController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Médico',
                      ),
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _clienteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cliente',
                      ),
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _receita.tipoReceitaId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Lista de tipos de receita',
                      ),
                      items: [_receita.tipoReceita].map((e) {
                        return DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.nome, overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: null,
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione um tipo de receita';
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
                      contentPadding: EdgeInsets.zero,
                      onChanged: null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _receita.notificacao?.codigo.uf,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'UF da notificação de receita',
                      ),
                      items: _estados.keys.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text('${_estados[e]} ($e)', overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _receita.notificacao?.codigo.codigo,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Código da notificação de receita',
                      ),
                      keyboardType: TextInputType.number,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _receita.notificacao?.tipoNotificacaoId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tipo de notificação',
                      ),
                      items: [_receita.notificacao?.tipoNotificacao].map((e) {
                        return DropdownMenuItem<String>(
                          value: e?.id,
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: e?.cor.value,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(e?.nome ?? '', overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: null,
                      validator: (value) {
                        if (value == null && _receita.notificacao != null) {
                          return 'Selecione um tipo de notificação';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: _receita.item.medicamentoId,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Medicamento',
                      ),
                      items: [_receita.item.medicamento].map((e) {
                        return DropdownMenuItem<String>(
                          value: e.id,
                          child: Text('${e.nome} ${e.miligramas} mg', overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _receita.item.quantidade.toString(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantidade de medicamentos (caixas)',
                      ),
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _receita.frequencia.toString(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Frequência de consumo (por dia)',
                      ),
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _total,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Valor total',
                      ),
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      child: const Text('Cancelar receita e restituir itens vendidos'),
                      onPressed: () async {
                        final state = _formKey.currentState;
                        if (state != null && state.validate()) {
                          try {
                            await ctx.read<IServiceReceita>().cancel(_receita);
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Receita cancelada com sucesso.'),
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
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        primary: Colors.red,
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
