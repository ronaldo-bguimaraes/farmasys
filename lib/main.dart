import 'package:farmasys/firebase_options.dart';
import 'package:farmasys/screen/cliente/cliente_add.dart';
import 'package:farmasys/screen/cliente/cliente_list.dart';
import 'package:farmasys/screen/home/home.dart';
import 'package:farmasys/screen/medicamento/medicamento_add.dart';
import 'package:farmasys/screen/medicamento/medicamento_list.dart';
import 'package:farmasys/screen/medico/medico_add.dart';
import 'package:farmasys/screen/medico/medico_list.dart';
import 'package:farmasys/screen/user/user_sign_in.dart';
import 'package:farmasys/screen/user/user_sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FarmaSys',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: UserSignIn.routeName,
      routes: {
        Home.routeName: (context) => const Home(),
        UserSignIn.routeName: (context) => const UserSignIn(),
        UserSignUp.routeName: (context) => const UserSignUp(),
        MedicoList.routeName: (context) => const MedicoList(),
        MedicoAdd.routeName: (context) => const MedicoAdd(),
        MedicamentoList.routeName: (context) => const MedicamentoList(),
        MedicamentoAdd.routeName: (context) => const MedicamentoAdd(),
        ClienteList.routeName: (context) => const ClienteList(),
        ClienteAdd.routeName: (context) => const ClienteAdd(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
