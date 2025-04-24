

import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActorsByMovieId(String movieId);
  // Future<List<String>> getActorsByMovieIdWithPagination(String movieId, int page);
  // Future<List<String>> getActorsByMovieIdWithPaginationAndFilter(String movieId, int page, String filter);
}