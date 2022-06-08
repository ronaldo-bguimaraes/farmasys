import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/enum/cor.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoNotificacaoForm extends StatefulWidget {
  final TipoNotificacao tipoNotificacao;

  const TipoNotificacaoForm({
    Key? key,
    required this.tipoNotificacao,
  }) : super(key: key);

  @override
  State<TipoNotificacaoForm> createState() => _TipoNotificacaoFormState();

  static Future<TipoNotificacao?> show(BuildContext ctx, [TipoNotificacao? tipoNotificacao]) async {
    return await showDialog<TipoNotificacao?>(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: Text('${tipoNotificacao == null ? "Cadastrar" : "Editar"} tipo de notificação'),
          content: TipoNotificacaoForm(
            tipoNotificacao: tipoNotificacao ?? TipoNotificacao(),
          ),
        );
      },
    );
  }
}

class _TipoNotificacaoFormState extends State<TipoNotificacaoForm> {
  final _formKey = GlobalKey<FormState>();

  late TipoNotificacao _tipoNotificacao;
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tipoNotificacao = widget.tipoNotificacao;
    _nomeController.text = _tipoNotificacao.nome;
  }

  @override
  Widget build(BuildContext ctx) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 300,
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
                    _tipoNotificacao.nome = value.trim().toUpperCase();
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
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _tipoNotificacao.cor.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cor',
                ),
                items: Cor.values.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.name,
                    child: Text(e.name.toUpperCase(), overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _tipoNotificacao.cor = Cor.getByName(value);
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
              Row(
                children: [
                  TextButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () async {
                      final state = _formKey.currentState;
                      if (state != null && state.validate()) {
                        try {
                          _tipoNotificacao = await ctx.read<IServiceTipoNotificacao>().save(_tipoNotificacao);
                          //
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text('Tipo de notificação salvo com sucesso.'),
                              duration: Duration(milliseconds: 1200),
                            ),
                          );
                          Navigator.of(ctx).pop(_tipoNotificacao);
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
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
