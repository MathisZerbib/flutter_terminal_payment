import 'package:flutter/material.dart';
import 'package:flutter_application_test/product_list.dart';
import 'package:flutter_application_test/provider/cart_provider.dart';
import 'package:flutter_application_test/setup_server.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Cash Manager',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: const MyHomePage(title: 'Home'),
          );
        },
      ),
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
                        builder: (context) => const ProductList()))),
                child: const Text(
                  'Start shopping!',
                ),
              )
            ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
