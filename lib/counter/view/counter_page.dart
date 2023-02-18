import 'package:ds_client/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late WebSocketChannel _channel;
  late String _count;

  @override
  void initState() {
    _count = '0';
    _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080/ws'));
    _channel.stream.listen(
      (data) => setState(() {
        _count = data as String;
      }),
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
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Center(child: CounterText(count: _count)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _channel.sink.add('__increment__'),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => _channel.sink.add('__decrement__'),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({
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
