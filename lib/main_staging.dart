import 'package:ds_client/app/app.dart';
import 'package:ds_client/bootstrap.dart';
import 'package:ds_client/colorswitch/utils.dart';

void main() {
  ColorSwitchConfig(
    values: ColorSwitchValues(
      baseDomain: 'ws://localhost:8080/ws',
    ),
  );
  bootstrap(() => const App());
}
