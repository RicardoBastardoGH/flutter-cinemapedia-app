import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia/config/constants/environments.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MovieDbDatasource extends MoviesDatasource {
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
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get('/movie/now_playing');

    // if (response.statusCode != 200) {
    //   throw Exception('Error al obtener las peliculas en cartelera');
    // }
    final List<dynamic> movieDBResponse = response.data['results'];

    final List<Movie> movies = movieDBResponse
    .where((moviedb) => moviedb['poster_path'] != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBTToEntity(moviedb),
    ).toList();

    return movies;
  }



}