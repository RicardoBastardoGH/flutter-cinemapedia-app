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
  }
  @override
  Widget build(BuildContext context) {

    // final nowPlayingMovies = ref.watch( nowPlayingMoviesProvider );
    final nowPlayingMovies = ref.watch( moviesSlideshowProvider );
    return Column(
      children: [

        CustomAppbar(),

        MoviesSlideshow(movies: nowPlayingMovies),

        MovieHorizontalListview(
          movies: nowPlayingMovies,
          title: 'En cines',
          subtitle: 'Lunes 20',  
        )
      ],
    );
  }
}