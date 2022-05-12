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
        return Medicamento.fromMap(snapshot.data()!);
      },
      toFirestore: (medicamento, options) {
        return medicamento.toMap();
      },
    );
  }
  @override
  Future<void> add(Medicamento dto) async {
    await _collecion.add(dto);
  }

  @override
  Future<void> delete(Medicamento dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Medicamento?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    var data = docSnapshot.data();
    data?.id = docSnapshot.id;
    return data;
  }

  @override
  Stream<List<Medicamento>> all() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        var data = snapshot.data();
        data.id = snapshot.id;
        return data;
      }).toList();
    });
  }

  @override
  Future<void> update(Medicamento dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
