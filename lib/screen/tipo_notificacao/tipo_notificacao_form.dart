import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/helper/full_scroll.dart';
import 'package:farmasys/service/interface/i_service_tipo_notificacao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoNotificacaoForm extends StatefulWidget {
  final String title;
  final TipoNotificacao tipoNotificacao;

  const TipoNotificacaoForm({Key? key, required this.tipoNotificacao, required this.title}) : super(key: key);

  @override
  State<TipoNotificacaoForm> createState() => _TipoNotificacaoFormState();
}

class _TipoNotificacaoFormState extends State<TipoNotificacaoForm> {
  final _formKey = GlobalKey<FormState>();

  final _tipoNotificacaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tipoNotificacaoController.text = widget.tipoNotificacao.descricao;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IServiceTipoNotificacao>(
      builder: (context, serviceTipoNotificacao, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: FullScroll(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _tipoNotificacaoController,
                      onChanged: (value) {
                        _tipoNotificacaoController.value = TextEditingValue(
                          text: value.toUpperCase(),
                          selection: _tipoNotificacaoController.selection,
                        );
                      },
                      initialValue: widget.tipoNotificacao.descricao,
                      onSaved: (value) {
                        if (value != null) {
                          widget.tipoNotificacao.descricao = value;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A descrição não pode ser vazia';
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
                            await serviceTipoNotificacao.save(widget.tipoNotificacao);
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
          ),
        );
      },
    );
  }
}
