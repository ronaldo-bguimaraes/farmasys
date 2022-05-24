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
        var dto = Cliente.fromMap(snapshot.data()!);
        dto.id = snapshot.id;
        return dto;
      },
      toFirestore: (cliente, options) {
        return cliente.toMap();
      },
    );
  }

  @override
  Future<void> add(Cliente dto) async {
    var ref = await _collecion.add(dto);
    dto.id = ref.id;
  }

  @override
  Future<List<Cliente>> all() async {
    var querySnapshot = await _collecion.get();
    return querySnapshot.docs.map((snapshot) => snapshot.data()).toList();
  }

  @override
  Future<void> delete(Cliente dto) async {
    await _collecion.doc(dto.id).delete();
  }

  @override
  Future<Cliente?> get(String id) async {
    var docSnapshot = await _collecion.doc(id).get();
    return docSnapshot.data();
  }

  @override
  Stream<List<Cliente>> streamAll() {
    return _collecion.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((snapshot) {
        return snapshot.data();
      }).toList();
    });
  }

  @override
  Future<void> update(Cliente dto) async {
    await _collecion.doc(dto.id).set(dto);
  }
}
