import 'package:farmasys/dto/tipo_notificacao.dart';
import 'package:farmasys/mapper/interface/i_mapper_tipo_notificacao.dart';
import 'package:farmasys/repository/firebase_repository_base.dart';
import 'package:farmasys/repository/interface/i_repository_tipo_notificacao.dart';

class FirebaseRepositoryTipoNotificacao<T extends TipoNotificacao> extends FirebaseRepositoryBase<T> implements IRepositoryTipoNotificacao<T> {
  FirebaseRepositoryTipoNotificacao(IMapperTipoNotificacao<T> mapper) : super('tiposNotificacao', mapper);
}
