import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/repository/interface/repository.dart';

class MedicamentoFirebaseRepository extends IRepository<Medicamento> {
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Medicamento> _collecion;

  MedicamentoFirebaseRepository() {
    _firestore = FirebaseFirestore.instance;
    _collecion =
        _firestore.collection('medicamentos').withConverter<Medicamento>(
      fromFirestore: (snapshot, options) {
        var dto = Medicamento.fromMap(snapshot.data()!);
        dto.id = snapshot.id;
        return dto;
      },
      toFirestore: (medicamento, options) {
        return medicamento.toMap();
      },
    );
  }
  @override
  Future<void> add(Medicamento dto) async {
    var ref = await _collecion.add(dto);
    dto.id = ref.id;
  }

  @override
  Future<List<Medicamento>> all() async {
    var querySnapshot = await _collecion.get();
    return querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
  }

  @override
  Future<void> delete(Medicamento dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Medicamento?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    return docSnapshot.data();
  }

  @override
  Stream<List<Medicamento>> streamAll() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        return snapshot.data();
      }).toList();
    });
  }

  @override
  Future<void> update(Medicamento dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
