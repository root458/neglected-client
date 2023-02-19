import 'package:ds_client/app/app.dart';
import 'package:ds_client/colorswitch/color_switch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders ColorSwitchPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(ColorSwitchPage), findsOneWidget);
    });
  });
}
