import 'dart:convert';

import 'package:ds_client/colorswitch/models/ccolor.dart';
import 'package:ds_client/colorswitch/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ColorSwitchPage extends StatefulWidget {
  const ColorSwitchPage({super.key});

  @override
  State<ColorSwitchPage> createState() => _ColorSwitchPageState();
}

class _ColorSwitchPageState extends State<ColorSwitchPage> {
  late WebSocketChannel _channel;
  late JsonEncoder _encoder;
  late JsonDecoder _decoder;
  Color _bgColor = Colors.white;

  @override
  void initState() {
    _encoder = const JsonEncoder();
    _decoder = const JsonDecoder();
    _channel = WebSocketChannel.connect(
      Uri.parse(ColorSwitchConfig.instance!.values.baseDomain),
    );
    _channel.stream.listen(
      (data) {
        setState(() {
          final color = CColor.fromJson(
            _decoder.convert(data as String) as Map<String, dynamic>,
          );
          _bgColor = Utils.getColor(color.color);
        });
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
      backgroundColor: _bgColor,
      body: Center(
        child: Container(
          height: 300,
          width: 800,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: _bgColor == Colors.black
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Colorfy',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SFBold',
                    color: _bgColor == Colors.black ? Colors.white : null,
                  ),
                ),
                Text(
                  'User ID: 3',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFRegular',
                    color: _bgColor == Colors.black ? Colors.white : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Personalize for your friends',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'SFRegular',
                    color: _bgColor == Colors.black ? Colors.white : null,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => _channel.sink
                          .add(_encoder.convert(CColor(color: 'red').toJson())),
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _channel.sink.add(
                        _encoder.convert(CColor(color: 'white').toJson()),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _channel.sink.add(
                        _encoder.convert(CColor(color: 'black').toJson()),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _channel.sink.add(
                        _encoder.convert(CColor(color: 'blue').toJson()),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _channel.sink.add(
                        _encoder.convert(CColor(color: 'green').toJson()),
                      ),
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
      ),
    );
  }
}
