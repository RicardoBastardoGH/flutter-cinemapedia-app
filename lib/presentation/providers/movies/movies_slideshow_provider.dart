


import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movies_providers.dart';

final moviesSlideshowProvider = Provider<List<Movie>>((ref) {

  final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );

  if ( nowPlayingMovies.isEmpty ) return [];//Si no hay peliculas en la lista, se retorna una lista vacia

  return nowPlayingMovies.sublist(0, 6);

});