import 'package:flutter/material.dart';
import 'package:flutter_application_test/nfc_reader_screen.dart';
import 'package:flutter_application_test/qr_code_screen.dart';
import 'package:flutter_application_test/setup_server.dart';
import 'package:flutter_application_test/shop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: (() => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SetupServer()))),
          )
        ],
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome Mathis',
              ),
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QrCodeScreen()))),
                child: const Text(
                  'QrCode',
                ),
              ),
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NfcReaderScreen()))),
                child: const Text(
                  'NFC',
                ),
              ),
              ElevatedButton(
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Shop()))),
                child: const Text(
                  'Shop',
                ),
              )
            ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
