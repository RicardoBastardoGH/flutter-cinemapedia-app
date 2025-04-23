// import 'package:cinemapedia/config/constants/environments.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      // ),
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
    ref.read( popularMoviesProvider.notifier ).loadNextPage();
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
    ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
  }
  @override
  Widget build(BuildContext context) {

    final initaLoading = ref.watch( initialLoadingProvider );
    if ( initaLoading ) return const FullScreenLoader();
    // final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final slideShowMovies = ref.watch( moviesSlideshowProvider );
    final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider  );
    final popularMovies = ref.watch( popularMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider  );
    final upcomingMovies = ref.watch( upcomingMoviesProvider  );
    
    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppbar(),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {

              return Column(
                children: [
                  // CustomAppbar(),
                  MoviesSlideshow(movies: slideShowMovies),
              
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En cines',
                    subtitle: 'Lunes 20',  
                    loadNextPage: () {
                      ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Proximamente',
                    subtitle: 'En este mes',  
                    loadNextPage: () {
                      ref.read( upcomingMoviesProvider.notifier ).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    // subtitle: 'En este mes',  
                    loadNextPage: () {
                      ref.read( popularMoviesProvider.notifier ).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor calificadas',
                    subtitle: 'Desde siempres',  
                    loadNextPage: () {
                      ref.read( topRatedMoviesProvider.notifier ).loadNextPage();
                    },
                  ),

                  const SizedBox( height: 10 ),
                ],
              );
            } ,
            childCount: 1
          ) 
        )

      ]
      
      
    );
  }
}