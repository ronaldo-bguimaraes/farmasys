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
        var dto = Farmaceutico.fromMap(snapshot.data()!);
        dto.id = snapshot.id;
        return dto;
      },
      toFirestore: (farmaceutico, options) {
        return farmaceutico.toMap();
      },
    );
  }
  @override
  Future<void> add(Farmaceutico dto) async {
    var ref = await _collecion.add(dto);
    dto.id = ref.id;
  }

  @override
  Future<List<Farmaceutico>> all() async {
    var querySnapshot = await _collecion.get();
    return querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
  }

  @override
  Future<void> delete(Farmaceutico dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Farmaceutico?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    return docSnapshot.data();
  }

  @override
  Stream<List<Farmaceutico>> streamAll() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        return snapshot.data();
      }).toList();
    });
  }

  @override
  Future<void> update(Farmaceutico dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
