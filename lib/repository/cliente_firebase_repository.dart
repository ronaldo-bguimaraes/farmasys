import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/repository/interface/repository.dart';

class ClienteFirebaseRepository extends IRepository<Cliente> {
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Cliente> _collecion;

  ClienteFirebaseRepository() {
    _firestore = FirebaseFirestore.instance;
    _collecion = _firestore.collection('clientes').withConverter<Cliente>(
      fromFirestore: (snapshot, options) {
        return Cliente.fromMap(snapshot.data()!);
      },
      toFirestore: (cliente, options) {
        return cliente.toMap();
      },
    );
  }

  @override
  Future<void> add(Cliente dto) async {
    await _collecion.add(dto);
  }

  @override
  Future<void> delete(Cliente dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Cliente?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    var data = docSnapshot.data();
    data?.id = docSnapshot.id;
    return data;
  }

  @override
  Stream<List<Cliente>> all() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        var data = snapshot.data();
        data.id = snapshot.id;
        return data;
      }).toList();
    });
  }

  @override
  Future<void> update(Cliente dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
