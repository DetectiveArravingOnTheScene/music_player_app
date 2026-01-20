import 'package:logger/logger.dart';

// I will move this to the main flavors, but i don't know what is appropriate.
// Should i log info into file in production? or should i just turn off logging?

// this only logs anything in debug mode
final Logger logger = Logger(
  filter: DevelopmentFilter(),
  level: Level.info,
  printer: SimplePrinter(),
);
