import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
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

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {

    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster' )
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get('/movie/now_playing', 
      queryParameters: {'page': page});

     return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    
    final response = await dio.get('/movie/popular', 
      queryParameters: {'page': page});

     return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
   final response = await dio.get('/movie/top_rated', 
      queryParameters: {'page': page});

     return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', 
      queryParameters: {'page': page});

     return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    
    final response = await dio.get('/movie/$id');

    // if (id.isEmpty) return Movie.empty();

    if (response.statusCode != 200) {
      throw Exception('Error al obtener la película con id: $id');
    }

    final movieDetails = MovieDetails.fromJson(response.data);

    final movie = MovieMapper.movieDetailsToEntity(movieDetails);

    return movie;
  }
  
  @override
  Future<List<Movie>> searchMovies(String query ) async {

    if (query.isEmpty) return [];
    
    final response = await dio.get('/search/movie', 
      queryParameters: {'query': query});

     return _jsonToMovies(response.data);
  }



}