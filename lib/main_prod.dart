import 'package:core/core.dart';
import 'main_common.dart';

void main() async {
  await mainCommon(Flavor.prod, 'api_keys_prod.env');
}
