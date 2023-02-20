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
                SelectableText(
                  'Colorfy',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SFBold',
                    color: _bgColor == Colors.black ? Colors.white : null,
                  ),
                ),
                SelectableText(
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
                SelectableText(
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
                    ColorAvatar(
                      channel: _channel,
                      encoder: _encoder,
                      color: Colors.red,
                      colorStr: 'red',
                    ),
                    ColorAvatar(
                      channel: _channel,
                      encoder: _encoder,
                      color: Colors.white,
                      colorStr: 'white',
                    ),
                    ColorAvatar(
                      channel: _channel,
                      encoder: _encoder,
                      color: Colors.black,
                      colorStr: 'black',
                    ),
                    ColorAvatar(
                      channel: _channel,
                      encoder: _encoder,
                      color: Colors.blue,
                      colorStr: 'blue',
                    ),
                    ColorAvatar(
                      channel: _channel,
                      encoder: _encoder,
                      color: Colors.green,
                      colorStr: 'green',
                    ),
                    ColorAvatar(
                      channel: _channel,
                      encoder: _encoder,
                      color: Colors.yellow,
                      colorStr: 'yellow',
                    ),
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

class ColorAvatar extends StatelessWidget {
  const ColorAvatar({
    required WebSocketChannel channel,
    required JsonEncoder encoder,
    required this.colorStr,
    required this.color,
    super.key,
  })  : _channel = channel,
        _encoder = encoder;

  final WebSocketChannel _channel;
  final JsonEncoder _encoder;
  final String colorStr;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _channel.sink.add(
          _encoder.convert(CColor(color: colorStr).toJson()),
        ),
        child: CircleAvatar(
          backgroundColor: color,
        ),
      ),
    );
  }
}
