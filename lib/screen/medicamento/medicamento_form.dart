import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/substancia.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicamentoForm extends StatefulWidget {
  final String title;
  final Medicamento medicamento;
  final List<Substancia> substancias;

  const MedicamentoForm({Key? key, required this.medicamento, required this.title, required this.substancias}) : super(key: key);

  @override
  State<MedicamentoForm> createState() => _MedicamentoFormState();
}

class _MedicamentoFormState extends State<MedicamentoForm> {
  final _formKey = GlobalKey<FormState>();

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
                        initialValue: widget.medicamento.nome,
                        onSaved: (value) {
                          if (value != null) {
                            widget.medicamento.nome = value;
                          }
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
                        value: widget.medicamento.principioAtivoId,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Lista de Controle',
                        ),
                        items: widget.substancias.map((e) {
                          final listaControle = e.listaControle;
                          return DropdownMenuItem<String>(
                            value: e.id,
                            child: Text('${e.nome} (lista de controle: ${listaControle?.descricao}'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            widget.medicamento.principioAtivoId = value!;
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
                      TextFormField(
                        initialValue: widget.medicamento.miligramas.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            widget.medicamento.miligramas = double.tryParse(value) ?? 0;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Miligramas',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Os miligramas não pode ser vazio';
                          }
                          double? miligramas = double.tryParse(value);
                          //
                          if (miligramas == null || miligramas < 0) {
                            return 'Miligramas inválidos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.medicamento.preco.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            widget.medicamento.preco = double.tryParse(value) ?? 0;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Preço',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O preço não pode ser vazio';
                          }
                          double? preco = double.tryParse(value);
                          //
                          if (preco == null || preco < 0) {
                            return 'Preço inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: widget.medicamento.quantidade.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            widget.medicamento.quantidade = int.tryParse(value) ?? 0;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Quantidade',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'A quantidade não pode ser vazia';
                          }
                          int? quantidade = int.tryParse(value);
                          //
                          if (quantidade == null || quantidade < 0) {
                            return 'Quantidade inválida';
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
                              await context.read<IServiceMedicamento>().save(widget.medicamento);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Medicamento salvo com sucesso!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
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
