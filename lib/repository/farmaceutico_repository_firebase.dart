import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/interface/repository_firebase.dart';

class FarmaceuticoFirebaseRepository extends IRepositoryFirebase<Farmaceutico> {
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Farmaceutico> _collecion;

  FarmaceuticoFirebaseRepository() {
    _firestore = FirebaseFirestore.instance;
    _collecion =
        _firestore.collection('farmaceuticos').withConverter<Farmaceutico>(
      fromFirestore: (snapshot, options) {
        return Farmaceutico.fromMap(snapshot.data()!);
      },
      toFirestore: (farmaceutico, options) {
        return farmaceutico.toMap();
      },
    );
  }
  @override
  Future<void> add(Farmaceutico dto) async {
    _collecion.add(dto);
  }

  @override
  Future<void> delete(Farmaceutico dto) async {
    _collecion.doc(dto.id).delete();
  }

  @override
  get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    var data = docSnapshot.data();
    data?.id = docSnapshot.id;
    return data;
  }

  @override
  Future<List<Farmaceutico>> list() async {
    var querySnapshot = await _collecion.get();
    return querySnapshot.docs.map((snapshot) {
      var data = snapshot.data();
      data.id = snapshot.id;
      return snapshot.data();
    }).toList();
  }

  @override
  Future<void> update(Farmaceutico dto) async {
    _collecion.doc(dto.id).set(dto);
  }

  @override
  listStream() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        var data = snapshot.data();
        data.id = snapshot.id;
        return snapshot.data();
      }).toList();
    });
  }
}
