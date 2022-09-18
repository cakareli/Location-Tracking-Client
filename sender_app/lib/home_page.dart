import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IO.Socket socket;
  double? latitude;
  double? longitude;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    // super.initState();
    try {
      socket = IO.io("http://192.168.1.35:3700", <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      socket.connect();

      socket.onConnect(
        (data) => debugPrint('Connect: ${socket.id}'),
      );
    } catch (err) {
      debugPrint("Error : " + err.toString());
    }
  }

  Future<void> initSocket() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter value';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Longitude',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter value';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Latitude',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      var data = {"lat": "1", "lng": "2"};
                      socket.emit(
                        'position-changed',
                        jsonEncode(data),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Processing Data'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
