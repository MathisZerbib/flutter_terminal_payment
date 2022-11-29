import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future postServer(String ipAddress, String portNumber, String password) async {
  final http.Response response = await http.post(
    Uri.parse('https://6385e7cbbeaa6458266ca53a.mockapi.io/setup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
      'username': '$ipAddress:$portNumber',
      'password': password,
    }),
  );
  if (response.statusCode == 201) {
    print(jsonDecode(response.body));
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class SetupServer extends StatelessWidget {
  const SetupServer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Server configuration')),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[FormServer()],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Create a Form widget.
class FormServer extends StatefulWidget {
  const FormServer({super.key});

  @override
  FormServerState createState() {
    return FormServerState();
  }
}

class FormServerState extends State<FormServer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController ipController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: ipController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Ip adress",
                      hintText: 'Enter your server IP',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid IP';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: portController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Port Number",
                      hintText: 'Enter the port number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid port number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "password",
                      hintText: 'Enter your password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                  try {
                    await postServer(
                        ipController.text.toString(),
                        portController.text.toString(),
                        passwordController.text.toString());
                  } catch (e) {
                    throw Exception(e);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
