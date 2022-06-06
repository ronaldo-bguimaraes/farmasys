import 'package:flutter/material.dart';

class ExclusionConfirmation extends StatelessWidget {
  final void Function(BuildContext context) onAccept;

  const ExclusionConfirmation({Key? key, required this.onAccept}) : super(key: key);

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
          onPressed: () => onAccept(context),
        ),
      ],
    );
  }

  static void show({required BuildContext context, required void Function(BuildContext context) onAccept}) {
    showDialog(
      context: context,
      builder: (context) {
        return ExclusionConfirmation(
          onAccept: onAccept,
        );
      },
    );
  }
}
