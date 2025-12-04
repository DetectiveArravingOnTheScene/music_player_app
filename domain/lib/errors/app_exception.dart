import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable {
  const AppException(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
