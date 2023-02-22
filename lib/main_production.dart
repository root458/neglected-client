import 'package:ds_client/app/app.dart';
import 'package:ds_client/bootstrap.dart';
import 'package:ds_client/colorswitch/utils.dart';
import 'package:uuid/uuid.dart';

void main() {
  final uuid = const Uuid().v4();
  ColorSwitchConfig(
    values: ColorSwitchValues(
      baseDomain: 'wss://colorfy-friends-kz2g8.ondigitalocean.app/ws?id=$uuid',
      clientUniqueID: uuid,
    ),
  );
  bootstrap(() => const App());
}
