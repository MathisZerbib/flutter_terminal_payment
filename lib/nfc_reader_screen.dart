import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcReaderScreen extends StatefulWidget {
  const NfcReaderScreen({super.key});

  @override
  State<StatefulWidget> createState() => NfcReaderScreenState();
}

class NfcReaderScreenState extends State<NfcReaderScreen> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nfc payement')),
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => ss.data != true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                          // 'Please enable your NFC: Nfc activated ? ${ss.data}'))
                          'Please enable your NFC'),
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() {}),
                      child: const Text('Reload'),
                    )
                  ],
                )
              : Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  direction: Axis.vertical,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        constraints: const BoxConstraints.expand(),
                        decoration: BoxDecoration(border: Border.all()),
                        child: SingleChildScrollView(
                          child: ValueListenableBuilder<dynamic>(
                            valueListenable: result,
                            builder: (context, value, _) =>
                                Text('${value ?? ''}'),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: GridView.count(
                        padding: const EdgeInsets.all(10),
                        crossAxisCount: 1,
                        childAspectRatio: 4,
                        children: [
                          ElevatedButton(
                            onPressed: _tagRead,
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(text: 'Pay with Nfc '),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Icon(Icons.credit_card),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      NfcManager.instance.stopSession();
    });
    if (result.value != null) {
      print(result.value);
    }
  }

  NdefMessage message = NdefMessage([
    NdefRecord.createText('Hello World!'),
    NdefRecord.createUri(Uri.parse('https://flutter.dev')),
    NdefRecord.createMime('text/plain', Uint8List.fromList('Hello'.codeUnits)),
    NdefRecord.createExternal(
        'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
  ]);
}
