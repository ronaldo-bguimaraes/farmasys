import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/repository/interface/repository.dart';

class MedicoFirebaseRepository extends IRepository<Medico> {
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Medico> _collecion;

  MedicoFirebaseRepository() {
    _firestore = FirebaseFirestore.instance;
    _collecion = _firestore.collection('medicos').withConverter<Medico>(
      fromFirestore: (snapshot, options) {
        var dto = Medico.fromMap(snapshot.data()!);
        dto.id = snapshot.id;
        return dto;
      },
      toFirestore: (medico, options) {
        return medico.toMap();
      },
    );
  }

  @override
  Future<void> add(Medico dto) async {
    var ref = await _collecion.add(dto);
    dto.id = ref.id;
  }

  @override
  Future<List<Medico>> all() async {
    var querySnapshot = await _collecion.get();
    return querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
  }

  @override
  Future<void> delete(Medico dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Medico?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    return docSnapshot.data();
  }

  @override
  Stream<List<Medico>> streamAll() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        return snapshot.data();
      }).toList();
    });
  }

  @override
  Future<void> update(Medico dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
