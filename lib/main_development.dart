import 'package:ds_client/app/app.dart';
import 'package:ds_client/bootstrap.dart';
import 'package:ds_client/colorswitch/utils.dart';
import 'package:uuid/uuid.dart';

void main() {
  // Generate User unique ID
  final uuid = const Uuid().v4();
  ColorSwitchConfig(
    values: ColorSwitchValues(
      baseDomain: 'ws://localhost:8080/ws?id=$uuid',
      clientUniqueID: uuid,
    ),
  );
  bootstrap(() => const App());
}
