import 'package:farmasys/dto/inteface/dto.dart';

class Medicamento extends Dto {
  String nome;

  Medicamento({
    required this.nome,
  });

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
