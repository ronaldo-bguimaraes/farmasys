import 'package:farmasys/firebase_options.dart';
import 'package:farmasys/provider/provider_dependencies.dart';
import 'package:farmasys/screen/cliente/cliente_list.dart';
import 'package:farmasys/screen/home/home.dart';
import 'package:farmasys/screen/medicamento/medicamento_inicio.dart';
import 'package:farmasys/screen/medico/medico_inicio.dart';
import 'package:farmasys/screen/tipo_receita/tipo_receita_inicio.dart';
import 'package:farmasys/screen/farmaceutico/farmaceutico_sign_in.dart';
import 'package:farmasys/screen/farmaceutico/farmaceutico_sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderDependencies(
      child: Main(),
    ),
  );
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmaSys',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: FarmaceuticoSignIn.routeName,
      routes: {
        Home.routeName: (context) => const Home(),
        FarmaceuticoSignIn.routeName: (context) => const FarmaceuticoSignIn(),
        FarmaceuticoSignUp.routeName: (context) => const FarmaceuticoSignUp(),
        MedicoInicio.routeName: (context) => const MedicoInicio(),
        ClienteList.routeName: (context) => const ClienteList(),
        TiposInicio.routeName: (context) => const TiposInicio(),
        MedicamentoInicio.routeName: (context) => const MedicamentoInicio(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
