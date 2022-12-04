import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/nfc_reader_screen.dart';
import 'package:flutter_application_test/provider/cart_provider.dart';
import 'package:flutter_application_test/qr_code_screen.dart';
import 'package:provider/provider.dart';

class PaymentChoosePage extends StatefulWidget {
  const PaymentChoosePage({super.key});

  @override
  PaymentChoosePageState createState() => PaymentChoosePageState();
}

class PaymentChoosePageState extends State<PaymentChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Charge method'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'how can customer pay ?',
              ),
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QrCodeScreen()))),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.qr_code),
                      Text('QR Code'),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (() => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NfcReaderScreen()))),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Icon(Icons.nfc),
                      Text('Nfc'),
                    ],
                  ),
                ),
              ),
            ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
