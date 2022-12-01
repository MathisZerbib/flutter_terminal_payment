import 'package:flutter/material.dart';
import 'package:flutter_application_test/nfc_reader_screen.dart';
import 'package:flutter_application_test/provider/cart_provider.dart';
import 'package:flutter_application_test/qr_code_screen.dart';
import 'package:flutter_application_test/setup_server.dart';
import 'package:provider/provider.dart';

class PaymentChoose extends StatelessWidget {
  const PaymentChoose({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const PaymentChoosePage(title: 'Home'),
          );
        },
      ),
    );
  }
}

class PaymentChoosePage extends StatefulWidget {
  final String title;

  const PaymentChoosePage({super.key, required this.title});

  @override
  PaymentChoosePageState createState() => PaymentChoosePageState();
}

class PaymentChoosePageState extends State<PaymentChoosePage> {
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
            ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
