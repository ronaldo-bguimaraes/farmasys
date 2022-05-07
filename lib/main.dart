import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/firebase_options.dart';
import 'package:farmasys/screen/usuario_sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmaSys',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsuarioSignUp(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
