import 'package:flutter/material.dart';

import 'ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Spgpw());
}

class Spgpw extends StatefulWidget {
  const Spgpw({Key? key}) : super(key: key);

  @override
  _SpgpwState createState() => _SpgpwState();
}

class _SpgpwState extends State<Spgpw> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPGPW',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
