import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/helper/full_scroll.dart';
import 'package:farmasys/service/interface/i_service_tipo_receita.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TipoReceitaForm extends StatefulWidget {
  final String title;
  final TipoReceita tipoReceita;

  const TipoReceitaForm({Key? key, required this.tipoReceita, required this.title}) : super(key: key);

  @override
  State<TipoReceitaForm> createState() => _TipoReceitaFormState();
}

class _TipoReceitaFormState extends State<TipoReceitaForm> {
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
                  initialValue: widget.tipoReceita.descricao,
                  onSaved: (value) {
                    if (value != null) {
                      widget.tipoReceita.descricao = value;
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
                        await context.read<IServiceTipoReceita>().save(widget.tipoReceita);
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
