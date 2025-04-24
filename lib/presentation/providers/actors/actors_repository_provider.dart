




// Este es inmutable, no se puede modificar, es de solo lectura
import 'package:cinemapedia/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource: ActorMoviedbDatasource());
});

