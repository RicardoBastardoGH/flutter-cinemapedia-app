import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movies_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon( Icons.movie_outlined, color: colors.primary, ),
              const SizedBox( width: 5 ),
              Text('Cinemapedia', style: textTheme.titleMedium  ),
              const Spacer(),

              IconButton(
                icon: Icon( Icons.search, color: colors.primary, ),
                onPressed: () async {
                  // final movieRepository = ref.read( movieRepositoryProvider );
                  final searchedMovies = ref.read( searchedMoviesProvider );
                  final searchQuery = ref.read( searchQueryProvider );
                   showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMoviesDelegate( 
                      initialMovies: searchedMovies,
                      searchMovies: ref.read( searchedMoviesProvider.notifier ).searchMoviesByQuery,
                      // searchMovies: ( query ) {
                      //   ref.read( searchQueryProvider.notifier ).update((state) => query );
                      //   return movieRepository.searchMovies( query );
                      // },
                    ),
                  ).then((movie) {
                    if ( movie == null ) return;
                    if (context.mounted) {
                      context.push('/movie/${ movie.id }');
                    }
                  });

                }, 
              )
              // const Spacer(),
              // Text('Cinemapedia', style: Theme.of(context).textTheme.titleLarge, ),
            ],
          ))
      )
    );
  }
}