import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/farmaceutico.dart';
import 'package:farmasys/repository/interface/repository.dart';

class FarmaceuticoFirebaseRepository extends IRepository<Farmaceutico> {
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
    await _collecion.add(dto);
  }

  @override
  Future<void> delete(Farmaceutico dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Farmaceutico?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    var data = docSnapshot.data();
    data?.id = docSnapshot.id;
    return data;
  }

  @override
  Stream<List<Farmaceutico>> all() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        var data = snapshot.data();
        data.id = snapshot.id;
        return data;
      }).toList();
    });
  }

  @override
  Future<void> update(Farmaceutico dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
