import 'package:core/core.dart';
import 'main_common.dart';

void main() async {
  await mainCommon(Flavor.dev, 'api_keys_dev.env');
}
