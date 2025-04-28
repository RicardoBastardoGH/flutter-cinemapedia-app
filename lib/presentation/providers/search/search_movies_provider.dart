import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final searchedMoviesProvider = StateNotifierProvider<SerachMoviesNotifier, List<Movie>>((ref) {
  final searchMovies = ref.read(movieRepositoryProvider).searchMovies;
  return SerachMoviesNotifier(
    searchMovies: searchMovies, 
    ref: ref);
});


typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SerachMoviesNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SerachMoviesNotifier({required this.searchMovies, required this.ref}) : super([]);

  Future <List<Movie>> searchMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);
    final List<Movie> movies = await searchMovies(query);
    
    state = movies;
    return movies;
  }


}