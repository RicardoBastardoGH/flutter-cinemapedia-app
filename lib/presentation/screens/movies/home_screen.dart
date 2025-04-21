import 'package:cinemapedia/config/constants/environments.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static const String routeName = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Text( Environments.theMovieDbKey ),
      ),
    );
  }
}