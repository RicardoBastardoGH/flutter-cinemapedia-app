


import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class SearchMoviesDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;

  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();

  Timer? debounceTimer;

  void closeStream() {
    debouncedMovies.close();
  }

  SearchMoviesDelegate({required this.searchMovies});
  void _onQueryChanged(String query) async {

    if ( debounceTimer?.isActive ?? false ) {
      // Cancel the previous timer if it's still active
      debounceTimer?.cancel();
    }
    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if ( query.isEmpty ) {
        debouncedMovies.add([]);
        return;
      }
      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
  }

  // change search label
  @override
  String get searchFieldLabel => 'Buscar película';
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [

      if ( query.isNotEmpty )
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              query = '';
            },
          ),
        ),
      // IconButton(
      //   icon: const Icon(Icons.search),
      //   onPressed: () {
      //     // Implement search functionality here
      //     // For example, you can call a method to fetch movies based on the query
      //     // and update the UI accordingly.
      //   },
      // ),
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
    return Center(
      child: Text(
        'Search for: $query',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }


  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return StreamBuilder(
      // future: searchMovies(query),
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        // if (snapshot.hasError) {
        //   return Center(child: Text('Error: ${snapshot.error}'));
        // }

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