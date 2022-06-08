import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoReceitaForm extends StatefulWidget {
  final TipoReceita tipoReceita;

  const TipoReceitaForm({
    Key? key,
    required this.tipoReceita,
  }) : super(key: key);

  @override
  State<TipoReceitaForm> createState() => _TipoReceitaFormState();

  static Future<TipoReceita?> show(BuildContext ctx, [TipoReceita? tipoReceita]) async {
    return await showDialog<TipoReceita?>(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: Text('${tipoReceita == null ? "Cadastrar" : "Editar"} tipo de receita'),
          content: TipoReceitaForm(
            tipoReceita: tipoReceita ?? TipoReceita(),
          ),
        );
      },
    );
  }
}

class _TipoReceitaFormState extends State<TipoReceitaForm> {
  final _formKey = GlobalKey<FormState>();

  late TipoReceita _tipoReceita;
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tipoReceita = widget.tipoReceita;
    _nomeController.text = _tipoReceita.nome;
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
                    _tipoReceita.nome = value.trim().toUpperCase();
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
                          _tipoReceita = await ctx.read<IServiceTipoReceita>().save(_tipoReceita);
                          //
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text('Tipo de receita salvo com sucesso.'),
                              duration: Duration(milliseconds: 1200),
                            ),
                          );
                          Navigator.of(ctx).pop(_tipoReceita);
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
