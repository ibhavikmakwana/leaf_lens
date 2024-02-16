import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:leaf_lens/home/home_screen.dart';
import 'package:leaf_lens/home/indentifying_screen/identifying_screen.dart';
import 'package:leaf_lens/theme.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leaf Lens',
      theme: MaterialTheme(Theme.of(context).textTheme).light(),
      darkTheme: MaterialTheme(Theme.of(context).textTheme).dark(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/':
            return MaterialPageRoute<void>(
              builder: (BuildContext context) => const HomeScreen(),
            );
          case IdentifyingScreen.routeName:
            if (args is XFile) {
              return MaterialPageRoute<void>(
                builder: (BuildContext context) => IdentifyingScreen(
                  image: args,
                ),
              );
            }
            break;
        }
        return null;
      },
    );
  }
}
