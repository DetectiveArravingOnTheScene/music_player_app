import 'package:logger/logger.dart';

// this only logs anything in debug mode
final Logger logger = Logger(
  filter: DevelopmentFilter(),
  level: Level.info,
  printer: SimplePrinter(),
);
