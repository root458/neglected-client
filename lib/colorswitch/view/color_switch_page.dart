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
      body: Center(child: ColorSwitchText(count: _count)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            // onPressed: () => _channel.sink.add('__increment__'),
            onPressed: () => _channel.sink
                .add(_encoder.convert(CColor(color: 'black').toJson())),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            // onPressed: () => _channel.sink.add('__decrement__'),
            onPressed: () => _channel.sink
                .add(_encoder.convert(CColor(color: 'red').toJson())),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class ColorSwitchText extends StatelessWidget {
  const ColorSwitchText({
    required this.count,
    super.key,
  });

  final String count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(count, style: theme.textTheme.displayLarge);
  }
}
