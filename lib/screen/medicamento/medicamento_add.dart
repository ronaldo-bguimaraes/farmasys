import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/repository/medicamento_firebase_repository.dart';
import 'package:farmasys/service/medicamento_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedicamentoAdd extends StatefulWidget {
  static const String routeName = '/medicamento-add';

  const MedicamentoAdd({Key? key}) : super(key: key);

  @override
  State<MedicamentoAdd> createState() => _MedicamentoAddState();
}

class _MedicamentoAddState extends State<MedicamentoAdd> {
  final _formKey = GlobalKey<FormState>();

  final _medicamento = Medicamento(
    nome: '',
    principioAtivo: '',
    miligramas: 0,
    preco: 0,
    quantidade: 0,
    controlado: false,
  );

  late final IRepository<Medicamento> _repository;
  late final MedicamentoService<Medicamento> _service;

  final _principioAtivoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _repository = MedicamentoFirebaseRepository();
    _service = MedicamentoService(_repository);

    _principioAtivoController.text = _medicamento.principioAtivo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Medicamento'),
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
                        initialValue: _medicamento.nome,
                        onSaved: (value) {
                          if (value != null) {
                            _medicamento.nome = value;
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
                      TextFormField(
                        controller: _principioAtivoController,
                        onChanged: (value) {
                          _principioAtivoController.value = TextEditingValue(
                            text: value.toUpperCase(),
                            selection: _principioAtivoController.selection,
                          );
                        },
                        onSaved: (value) {
                          if (value != null) {
                            _medicamento.principioAtivo = value;
                          }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Principio ativo',
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O princípio ativo não pode ser vazio';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _medicamento.miligramas.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            _medicamento.miligramas = double.parse(value);
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
                          if (int.parse(value) < 0) {
                            return 'Miligramas inválidos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _medicamento.preco.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            _medicamento.preco = double.parse(value);
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
                          if (int.parse(value) < 0) {
                            return 'Preço inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _medicamento.quantidade.toString(),
                        onSaved: (value) {
                          if (value != null) {
                            _medicamento.quantidade = int.parse(value);
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
                          if (int.parse(value) < 0) {
                            return 'Quantidade inválida';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Controlado',
                          ),
                          Switch(
                            value: _medicamento.controlado,
                            onChanged: (value) {
                              setState(() {
                                _medicamento.controlado = value;
                              });
                            },
                          ),
                        ],
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
                              await _service.add(_medicamento);
                              Navigator.of(context).pop();
                            }
                            //
                            on FirebaseAuthException catch (error) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Erro'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text('${error.message}'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            // catch end
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
