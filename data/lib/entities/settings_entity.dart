import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SettingsEntity {
  final String theme;
  final String locale;

  SettingsEntity({required this.theme, required this.locale});
}
