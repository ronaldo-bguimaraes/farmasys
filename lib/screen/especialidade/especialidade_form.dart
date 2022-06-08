import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/service/interface/i_service_especialidade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EspecialidadeForm extends StatefulWidget {
  final Especialidade especialidade;

  const EspecialidadeForm({
    Key? key,
    required this.especialidade,
  }) : super(key: key);

  @override
  State<EspecialidadeForm> createState() => _EspecialidadeFormState();

  static Future<Especialidade?> show(BuildContext ctx, [Especialidade? especialidade]) async {
    return await showDialog<Especialidade?>(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: Text('${especialidade == null ? "Cadastrar" : "Editar"} especialidade'),
          content: EspecialidadeForm(
            especialidade: especialidade ?? Especialidade(),
          ),
        );
      },
    );
  }
}

class _EspecialidadeFormState extends State<EspecialidadeForm> {
  final _formKey = GlobalKey<FormState>();

  late Especialidade _especialidade;
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _especialidade = widget.especialidade;
    _nomeController.text = _especialidade.nome;
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
                    _especialidade.nome = value.trim();
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
                          _especialidade = await ctx.read<IServiceEspecialidade>().save(_especialidade);
                          //
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text('Especialidade salva com sucesso.'),
                              duration: Duration(milliseconds: 1200),
                            ),
                          );
                          Navigator.of(ctx).pop(_especialidade);
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
