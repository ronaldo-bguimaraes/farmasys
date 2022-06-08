import 'package:flutter/material.dart';

enum Cor {
  amarela(Colors.yellow),
  azul(Colors.blue),
  branca(Colors.white);

  final Color value;
  const Cor(this.value);

  static Cor getByName(String? name) {
    return Cor.values.firstWhere((e) => e.name == name, orElse: () => Cor.branca);
  }
}
