import 'package:farmasys/dto/inteface/user_dto.dart';
import 'package:farmasys/repository/interface/repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService<T extends UserDto> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final IRepository<T> _userRepository;

  UserService(this._userRepository);

  Future<T?> getCurrentUser() async {
    if (_auth.currentUser != null) {
      return await _userRepository.get(_auth.currentUser!.uid);
    }
    return null;
  }

  createUserWithEmailAndPassword(T user) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.senha,
      );
      if (userCredential.user != null) {
        // set firestore user data
        await _userRepository.update(user);
      }
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
    }
  }

  signInWithEmailAndPassword(T user) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.senha,
      );
      if (userCredential.user != null) {
        // get firestore user data
        await _userRepository.get(userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
    }
  }

  signOut(T usuario) async {
    try {
      await _auth.signOut();
      //
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
    }
  }
}
