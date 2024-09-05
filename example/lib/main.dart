import 'package:flutter/material.dart';
import 'package:muq_snackbar/muq_snackbar.dart';
import 'package:muq_snackbar/utils/muq_snackbar_enum.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            MuqSnackbar(
              context: context,
              title: "MuqSnackbar",
              content: "This is a MuqSnackbar with bottom position",
              leading: const Icon(Icons.info, color: Colors.blue),
              position: MuqPosition.bottom,
              closeBuilder: (context, closeFunction) {
                return IconButton(
                  onPressed: closeFunction,
                  icon: const Icon(Icons.close),
                );
              },
            );
          },
          child: const Text(
            "Show MuqSnackbar",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
