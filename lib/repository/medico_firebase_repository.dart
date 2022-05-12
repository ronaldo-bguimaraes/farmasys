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
        return Medico.fromMap(snapshot.data()!);
      },
      toFirestore: (medico, options) {
        return medico.toMap();
      },
    );
  }
  @override
  Future<void> add(Medico dto) async {
    await _collecion.add(dto);
  }

  @override
  Future<void> delete(Medico dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Medico?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    var data = docSnapshot.data();
    data?.id = docSnapshot.id;
    return data;
  }

  @override
  Stream<List<Medico>> all() {
    var controller = StreamController<List<Medico>>();
    _collecion.snapshots().listen((event) {
      controller.add(event.docs.map((snapshot) {
        var data = snapshot.data();
        data.id = snapshot.id;
        return data;
      }).toList());
    });
    return controller.stream;
  }

  @override
  Future<void> update(Medico dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
