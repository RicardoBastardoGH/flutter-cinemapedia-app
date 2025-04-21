import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

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
                onPressed: (){}, 
              )
              // const Spacer(),
              // Text('Cinemapedia', style: Theme.of(context).textTheme.titleLarge, ),
            ],
          ))
      )
    );
  }
}