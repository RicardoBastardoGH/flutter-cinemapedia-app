import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  Stream <String> getLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Comprando palomitas de maiz',
      'Cargando películas',
      'Ya mero....',
      'Esta tardando muhco :( ',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Espere por favor...'),
          SizedBox(height: 15),
          const CircularProgressIndicator(strokeWidth: 2,),
          SizedBox(height: 15),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');
              return Text(snapshot.data!);
            })

        ],  
      ),
    );
  }
}