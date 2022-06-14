import 'package:farmasys/dto/medico.dart';
import 'package:farmasys/dto/medicamento.dart';
import 'package:farmasys/dto/cliente.dart';
import 'package:farmasys/dto/notificacao.dart';
import 'package:farmasys/dto/receita.dart';
import 'package:farmasys/dto/tipo_receita.dart';
import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_receita.dart';
import 'package:farmasys/repository/firebase/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_receita.dart';

class FirebaseRepositoryReceita extends FirebaseRepositoryBase<Receita> implements IRepositoryReceita {
  // ignore: unused_field
  final IMapperReceita _mapper;

  FirebaseRepositoryReceita(this._mapper) : super('receitas', _mapper);

  @override
  Future<Receita?> getByNotificacao(Notificacao notificacao) async {
    final query = await firestore.collection(tableName).where('notificacao.codigo.uf', isEqualTo: notificacao.codigo.uf).where('notificacao.codigo.codigo', isEqualTo: notificacao.codigo.codigo).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }

  @override
  Future<Receita?> getByCliente(Cliente cliente) async {
    final query = await firestore.collection(tableName).where('clienteId', isEqualTo: cliente.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }

  @override
  Future<Receita?> getByMedicamento(Medicamento medicamento) async {
    final query = await firestore.collection(tableName).where('item.medicamentoId', isEqualTo: medicamento.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }

  @override
  Future<Receita?> getByMedico(Medico medico) async {
    final query = await firestore.collection(tableName).where('medicoId', isEqualTo: medico.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }

  @override
  Future<Receita?> getByTipoNotificacao(TipoNotificacao tipoNotificacao) async {
    final query = await firestore.collection(tableName).where('notificacao.tipoNotificacaoId', isEqualTo: tipoNotificacao.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }

  @override
  Future<Receita?> getByTipoReceita(TipoReceita tipoReceita) async {
    final query = await firestore.collection(tableName).where('tipoReceitaId', isEqualTo: tipoReceita.id).get();
    if (query.docs.isEmpty) {
      return null;
    }
    final map = query.docs.first.data();
    map.addAll({
      'id': query.docs.first.id,
    });
    return mapper.fromMap(map);
  }
}
