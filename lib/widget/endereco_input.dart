import 'package:flutter/material.dart';

class EnderecoForm extends StatefulWidget {
  const EnderecoForm({Key? key}) : super(key: key);

  @override
  State<EnderecoForm> createState() => _EnderecoFormState();
}

class _EnderecoFormState extends State<EnderecoForm> {
  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _bairroController = TextEditingController();
  final _ruaController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text('CEP'),
              TextFormField(
                controller: _cepController,
              )
            ],
          ),
        ],
      ),
    );
  }
}
