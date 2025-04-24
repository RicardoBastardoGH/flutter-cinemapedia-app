


import 'package:cinemapedia/config/constants/environments.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';


class ActorMoviedbDatasource extends ActorsDatasource {

final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    headers: {
      // 'Content-Type': 'application/json;charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Environments.theMovieDbKey}',
    },
    queryParameters: {
      // 'api_key': Environments.theMovieDbKey,
      'language': 'es-MX',
      // 'page': 1,
    },
  ));


List<Actor> _jsonToActor(Map<String, dynamic> json) {

    final creditsDBResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = creditsDBResponse.cast
    // .where((actordb) => actordb.posterPath != 'no-poster' )
    .map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async{

    final response = await dio.get('/movie/$movieId/credits', );

    return _jsonToActor(response.data);
    // if (response.statusCode == 200) {
    //   return _jsonToActor(response.data);
    // }

    // return [].toList();
  }
}