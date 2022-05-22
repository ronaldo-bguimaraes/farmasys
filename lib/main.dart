import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/firebase_options.dart';
import 'package:farmasys/repository/farmaceutico_firebase_repository.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:farmasys/screen/cliente/cliente_add.dart';
import 'package:farmasys/screen/cliente/cliente_list.dart';
import 'package:farmasys/screen/home/home.dart';
import 'package:farmasys/screen/medicamento/medicamento_add.dart';
import 'package:farmasys/screen/medicamento/medicamento_list.dart';
import 'package:farmasys/screen/medico/medico_add.dart';
import 'package:farmasys/screen/medico/medico_list.dart';
import 'package:farmasys/screen/user/user_sign_in.dart';
import 'package:farmasys/screen/user/user_sign_up.dart';
import 'package:farmasys/service/authenticator_firebase.dart';
import 'package:farmasys/service/interface/authentication_service.dart';
import 'package:farmasys/service/user_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  late final IRepository<Farmaceutico> _repository;
  late final IAuthenticator<Farmaceutico> _auth;
  late final UserServiceFirebase<Farmaceutico> _service;

  @override
  void initState() {
    super.initState();
    _repository = FarmaceuticoFirebaseRepository();
    _auth = FirebaseAuthenticator(_repository);
    _service = UserServiceFirebase(_auth);
    //
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'FarmaSys',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Home.routeName,
        routes: {
          Home.routeName: (context) => const Home(),
          //
          UserSignIn.routeName: (context) => const UserSignIn(),
          UserSignUp.routeName: (context) => const UserSignUp(),
          //
          MedicoList.routeName: (context) => const MedicoList(),
          MedicoAdd.routeName: (context) => const MedicoAdd(),
          //
          MedicamentoList.routeName: (context) => const MedicamentoList(),
          MedicamentoAdd.routeName: (context) => const MedicamentoAdd(),
          //
          ClienteList.routeName: (context) => const ClienteList(),
          ClienteAdd.routeName: (context) => const ClienteAdd(),
        },
        debugShowCheckedModeBanner: false,
      ),
      providers: [
        Provider<UserServiceFirebase<Farmaceutico>>(
          create: (context) {
            return _service;
          },
        ),
        StreamProvider<Future<Farmaceutico?>>(
          create: (context) {
            return _service.getUserChanges();
          },
          initialData: Future.value(null),
        ),
      ],
    );
  }
}