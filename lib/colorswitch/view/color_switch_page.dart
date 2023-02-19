import 'dart:convert';

import 'package:ds_client/colorswitch/models/ccolor.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ColorSwitchPage extends StatefulWidget {
  const ColorSwitchPage({super.key});

  @override
  State<ColorSwitchPage> createState() => _ColorSwitchPageState();
}

class _ColorSwitchPageState extends State<ColorSwitchPage> {
  late WebSocketChannel _channel;
  late String _count;
  late JsonEncoder _encoder;
  late JsonDecoder _decoder;

  @override
  void initState() {
    _encoder = const JsonEncoder();
    _decoder = const JsonDecoder();
    _count = 'Not set';
    _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));
    _channel.stream.listen(
      (data) {
        setState(() {
          _count = data as String;
        });
        // _channel.sink.add(_encoder.convert(CColor(color: 'black').toJson())),
        // final color = CColor.fromJson(
        //   _decoder.convert(data as String) as Map<String, String>,
        // );
        // print(color.toJson());
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          height: 300,
          width: 800,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Colorfy'),
              const Text('User ID: 3'),
              const SizedBox(
                height: 20,
              ),
              const Text('Personalize for your friends'),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _channel.sink
                        .add(_encoder.convert(CColor(color: 'red').toJson())),
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _channel.sink
                        .add(_encoder.convert(CColor(color: 'white').toJson())),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _channel.sink
                        .add(_encoder.convert(CColor(color: 'black').toJson())),
                    child: const CircleAvatar(
                      backgroundColor: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _channel.sink
                        .add(_encoder.convert(CColor(color: 'blue').toJson())),
                    child: const CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _channel.sink
                        .add(_encoder.convert(CColor(color: 'green').toJson())),
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _channel.sink.add(
                      _encoder.convert(CColor(color: 'yellow').toJson()),
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.yellow,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}