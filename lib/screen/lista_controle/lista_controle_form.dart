import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/service/interface/i_service_lista_controle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaControleForm extends StatefulWidget {
  final String title;
  final ListaControle listaControle;

  const ListaControleForm({Key? key, required this.listaControle, required this.title}) : super(key: key);

  @override
  State<ListaControleForm> createState() => _ListaControleFormState();
}

class _ListaControleFormState extends State<ListaControleForm> {
  final _formKey = GlobalKey<FormState>();

  final _listaControleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _listaControleController.text = widget.listaControle.descricao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _listaControleController,
                        onChanged: (value) {
                          _listaControleController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: _listaControleController.selection,
                          );
                        },
                        onSaved: (value) {
                          if (value != null) {
                            widget.listaControle.descricao = value;
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
                      TextFormField(
                        initialValue: widget.listaControle.dispensacaoMaxima.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            widget.listaControle.dispensacaoMaxima = int.tryParse(value) ?? 0;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Dispensação máxima',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A dispensação máxima não pode ser vazia';
                          }
                          int? dispensacaoMaxima = int.tryParse(value);
                          //
                          if (dispensacaoMaxima == null || dispensacaoMaxima < 0) {
                            return 'Dispensação máxima inválida';
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
                              await context.read<IServiceListaControle>().save(widget.listaControle);
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
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}
