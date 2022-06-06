import 'package:farmasys/dto/especialidade.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/service/interface/i_service_lista_especialidade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EspecialidadeForm extends StatefulWidget {
  final String title;
  final Especialidade especialidade;

  const EspecialidadeForm({Key? key, required this.especialidade, required this.title}) : super(key: key);

  @override
  State<EspecialidadeForm> createState() => _EspecialidadeFormState();
}

class _EspecialidadeFormState extends State<EspecialidadeForm> {
  final _formKey = GlobalKey<FormState>();

  final _especialidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _especialidadeController,
                  onChanged: (value) {
                    _especialidadeController.value = TextEditingValue(
                      text: value.toUpperCase(),
                      selection: _especialidadeController.selection,
                    );
                  },
                  onSaved: (value) {
                    if (value != null) {
                      widget.especialidade.descricao = value.trim();
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Descrição',
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
                        Navigator.of(context).pop();
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
                        var state = _formKey.currentState;
                        if (state != null) {
                          state.save();
                        }
                        if (state != null && state.validate()) {
                          try {
                            await context.read<IServiceEspecialidade>().save(widget.especialidade);
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
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            ),
          ),
        ),
      ),
    );
  }
}
