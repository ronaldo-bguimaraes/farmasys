import 'package:flutter/material.dart';

typedef ExclusionAcceptFunction = void Function(Function close);

class ExclusionConfirmation extends StatelessWidget {
  final ExclusionAcceptFunction _onAccept;

  const ExclusionConfirmation({
    Key? key,
    required ExclusionAcceptFunction onPressed,
  })  : _onAccept = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: const [
          Icon(
            Icons.warning,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text('Confirmação'),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: const [
            Text(
              'Voce tem certeza que deseja apagar esse registro?',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCELAR'),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text(
            'APAGAR',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          onPressed: () {
            _onAccept(() {
              Navigator.of(context).pop();
            });
          },
        ),
      ],
    );
  }
}

void showExclusionConfirmation({
  required BuildContext context,
  required ExclusionAcceptFunction onAccept,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return ExclusionConfirmation(
        onPressed: onAccept,
      );
    },
  );
}
