import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/principio_ativo.dart';
import 'package:farmasys/exception/exception_message.dart';
import 'package:farmasys/screen/component/full_scroll.dart';
import 'package:farmasys/screen/principio_ativo/principio_ativo_form.dart';
import 'package:farmasys/service/interface/i_service_medicamento.dart';
import 'package:farmasys/service/interface/i_service_principio_ativo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicamentoForm extends StatefulWidget {
  final String title;
  final Medicamento medicamento;
  final List<PrincipioAtivo> principiosAtivos;

  const MedicamentoForm({Key? key, required this.medicamento, required this.title, required this.principiosAtivos}) : super(key: key);

  @override
  State<MedicamentoForm> createState() => _MedicamentoFormState();

  static Future<PrincipioAtivo?> show(BuildContext ctx, [Medicamento? medicamento]) async {
    final principiosAtivos = await ctx.read<IServicePrincipioAtivo>().getAll();
    return Navigator.of(ctx).push<PrincipioAtivo?>(
      MaterialPageRoute(
        builder: (ctx) {
          return MedicamentoForm(
            title: '${medicamento == null ? "Cadastrar" : "Editar"} medicamento',
            medicamento: medicamento ?? Medicamento(),
            principiosAtivos: principiosAtivos,
          );
        },
      ),
    );
  }
}

class _MedicamentoFormState extends State<MedicamentoForm> {
  final _formKey = GlobalKey<FormState>();

  late Medicamento _medicamento;
  final _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _medicamento = widget.medicamento;
    _nomeController.text = _medicamento.nome;
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          return FullScroll(
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                          _medicamento.nome = value;
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
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _medicamento.principioAtivoId,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Princípio ativo',
                            ),
                            items: widget.principiosAtivos.map((e) {
                              final listaControle = e.listaControle;
                              return DropdownMenuItem<String>(
                                value: e.id,
                                child: Text('${e.nome} - ${listaControle != null ? "Lista ${listaControle.nome}" : "Sem lista de controle"}', overflow: TextOverflow.ellipsis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _medicamento.principioAtivo = widget.principiosAtivos.firstWhere((e) => e.id == value);
                                _medicamento.principioAtivoId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Selecione um princípio ativo';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            final principioAtivo = await PrincipioAtivoForm.show(ctx);
                            if (principioAtivo != null) {
                              widget.principiosAtivos.add(principioAtivo);
                              widget.principiosAtivos.sort((a, b) => a.nome.compareTo(b.nome));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(
                              15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _medicamento.miligramas.toString(),
                      onChanged: (value) {
                        setState(() {
                          _medicamento.miligramas = double.tryParse(value) ?? 0;
                        });
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
                      initialValue: _medicamento.preco.toString(),
                      onChanged: (value) {
                        setState(() {
                          _medicamento.preco = double.tryParse(value) ?? 0;
                        });
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
                      initialValue: _medicamento.comprimidos.toString(),
                      onChanged: (value) {
                        setState(() {
                          _medicamento.comprimidos = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantidade de comprimidos por caixa',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A quantidade de comprimidos não pode ser vazia';
                        }
                        int? comprimidos = int.tryParse(value);
                        //
                        if (comprimidos == null || comprimidos < 0) {
                          return 'Quantidade de comprimidos inválida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      initialValue: _medicamento.quantidade.toString(),
                      onChanged: (value) {
                        setState(() {
                          _medicamento.quantidade = int.tryParse(value) ?? 0;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantidade disponível',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'A quantidade disponível não pode ser vazia';
                        }
                        int? quantidade = int.tryParse(value);
                        //
                        if (quantidade == null || quantidade < 0) {
                          return 'Quantidade disponível inválida';
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
                        final state = _formKey.currentState;
                        if (state != null && state.validate()) {
                          try {
                            _medicamento = await ctx.read<IServiceMedicamento>().save(_medicamento);
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                content: Text('Medicamento salvo com sucesso.'),
                                duration: Duration(milliseconds: 1200),
                              ),
                            );
                            Navigator.of(ctx).pop(_medicamento);
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
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
