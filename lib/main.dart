import 'package:ccms/database/objectbox.dart';
import 'package:ccms/features/presentation/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late Databox databox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databox = await Databox.create();
  // ProviderScope(child: child)
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.yellow, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}
