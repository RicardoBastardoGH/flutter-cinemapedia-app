
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';



final movieMapProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch( movieRepositoryProvider ).getMovieById;
  return MovieMapNotifier(getMovie);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

// Notifier to manage the state of a movie map
class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallback getMovie;

  MovieMapNotifier(this.getMovie) : super({});  

  Future <void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovie(movieId);

    state = {
      ...state,
      movieId: movie,
    };
  }
  
}

