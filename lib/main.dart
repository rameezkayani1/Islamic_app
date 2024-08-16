import 'package:flutter/material.dart';
import 'package:flutter_application_1/Islamic.dart/QuranScreen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'DirectWhatsapp/whatsHomeScreen.dart';
import 'Islamic.dart/HomScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox('scanned_results');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scenner ',
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
