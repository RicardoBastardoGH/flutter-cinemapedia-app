


import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class SearchMoviesDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  
  StreamController<bool> isLoadingStream = StreamController.broadcast();



  Timer? debounceTimer;

  void closeStream() {
    debouncedMovies.close();
  }

  SearchMoviesDelegate({
    required this.searchMovies, 
    required this.initialMovies
  }) {
    debouncedMovies.add(initialMovies);
  }
  void _onQueryChanged(String query) async {

      isLoadingStream.add(true);
    if ( debounceTimer?.isActive ?? false ) {
      // Cancel the previous timer if it's still active
      debounceTimer?.cancel();
    }
    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
      initialMovies = movies;
      isLoadingStream.add(false);
    });
  }

  // change search label
  @override
  String get searchFieldLabel => 'Buscar película';
  
  Widget buildResultsAndSuggestions(){
    return StreamBuilder(
    initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        if (movies.isEmpty) {
          return const Center(child: Text('No results found'));
        }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie, 
              onMovieSelected: (context, movie) {
                closeStream();
                close(context, movie);
              }
            );
          },
        );
      },  
    ) ;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [

      // if isLoadingStream is true, show a loading indicator
      // else show a clear button
      StreamBuilder<bool>(
        stream: isLoadingStream.stream,
        initialData: false,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;
          if (isLoading) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              animate: query.isNotEmpty,
              child: IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () {
                  query = '';
                },
              ),
            );
          } else {
            return FadeIn(
              animate: query.isNotEmpty,
              duration: const Duration(milliseconds: 300),
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  query = '';
                },
              ),
            );
          }
        },
      ),
        
      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        closeStream();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return buildResultsAndSuggestions();
  }
  // This class is a placeholder for the search movies delegate.
  // You can implement the search functionality here.
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
  });


  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme.primary;
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // Implement the action when a movie is selected
        // For example, you can navigate to a movie details page or perform any other action.
        // Navigator.pushNamed(context, 'movieDetails', arguments: movie);
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            FadeInLeft(
              duration: const Duration(milliseconds: 300),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  height: 100,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FadeInLeft(
                duration: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text(movie.overview, style: const TextStyle(fontSize: 14), maxLines: 3, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow.shade800, size: 15),
                        const SizedBox(width: 5),
                        Text(HumanFormats.number(movie.voteAverage, 1), style: textStyles.bodyMedium ?.copyWith(color: Colors.yellow.shade800)), 
                        // const SizedBox(width: 10),
                        // const Icon(Icons.calendar_today, size: 15),
                        // const SizedBox(width: 5),
                        // Text('${movie.releaseDate}', style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      //     ],
      //   )
      ),
    ); 
  }
}