import 'package:farmasys/dto/lista_controle.dart';
import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/helper/full_scroll.dart';
import 'package:farmasys/service/interface/i_service_substancia.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubstanciaForm extends StatefulWidget {
  final String title;
  final Substancia substancia;
  final List<ListaControle> listasControle;

  const SubstanciaForm({Key? key, required this.substancia, required this.listasControle, required this.title}) : super(key: key);

  @override
  State<SubstanciaForm> createState() => _SubstanciaFormState();
}

class _SubstanciaFormState extends State<SubstanciaForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  initialValue: widget.substancia.nome,
                  onChanged: (value) {
                    widget.substancia.nome = value;
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
                  value: widget.substancia.listaControleId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Lista de Controle',
                  ),
                  items: widget.listasControle.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.id,
                      child: Text('${e.descricao} (dispensação max.: ${e.dispensacaoMaxima})'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      widget.substancia.listaControleId = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecione uma lista de controle';
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
                        await context.read<IServiceSubstancia>().save(widget.substancia);
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
  }
}
