// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState()';
}


}

/// @nodoc
class $SignUpStateCopyWith<$Res>  {
$SignUpStateCopyWith(SignUpState _, $Res Function(SignUpState) __);
}


/// Adds pattern-matching-related methods to [SignUpState].
extension SignUpStatePatterns on SignUpState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InputSignUp value)?  input,TResult Function( SubmittingSignUp value)?  submitting,TResult Function( SuccessSignUp value)?  success,TResult Function( FailureSignUp value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InputSignUp() when input != null:
return input(_that);case SubmittingSignUp() when submitting != null:
return submitting(_that);case SuccessSignUp() when success != null:
return success(_that);case FailureSignUp() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InputSignUp value)  input,required TResult Function( SubmittingSignUp value)  submitting,required TResult Function( SuccessSignUp value)  success,required TResult Function( FailureSignUp value)  failure,}){
final _that = this;
switch (_that) {
case InputSignUp():
return input(_that);case SubmittingSignUp():
return submitting(_that);case SuccessSignUp():
return success(_that);case FailureSignUp():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InputSignUp value)?  input,TResult? Function( SubmittingSignUp value)?  submitting,TResult? Function( SuccessSignUp value)?  success,TResult? Function( FailureSignUp value)?  failure,}){
final _that = this;
switch (_that) {
case InputSignUp() when input != null:
return input(_that);case SubmittingSignUp() when submitting != null:
return submitting(_that);case SuccessSignUp() when success != null:
return success(_that);case FailureSignUp() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password,  String confirmPassword,  String? emailError,  String? passwordError,  String? confirmPasswordError,  bool isValid)?  input,TResult Function( String email,  String password,  String confirmPassword)?  submitting,TResult Function()?  success,TResult Function( String errorMessage,  String email,  String password,  String confirmPassword,  String? emailError,  String? passwordError,  String? confirmPasswordError,  bool isValid)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InputSignUp() when input != null:
return input(_that.email,_that.password,_that.confirmPassword,_that.emailError,_that.passwordError,_that.confirmPasswordError,_that.isValid);case SubmittingSignUp() when submitting != null:
return submitting(_that.email,_that.password,_that.confirmPassword);case SuccessSignUp() when success != null:
return success();case FailureSignUp() when failure != null:
return failure(_that.errorMessage,_that.email,_that.password,_that.confirmPassword,_that.emailError,_that.passwordError,_that.confirmPasswordError,_that.isValid);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password,  String confirmPassword,  String? emailError,  String? passwordError,  String? confirmPasswordError,  bool isValid)  input,required TResult Function( String email,  String password,  String confirmPassword)  submitting,required TResult Function()  success,required TResult Function( String errorMessage,  String email,  String password,  String confirmPassword,  String? emailError,  String? passwordError,  String? confirmPasswordError,  bool isValid)  failure,}) {final _that = this;
switch (_that) {
case InputSignUp():
return input(_that.email,_that.password,_that.confirmPassword,_that.emailError,_that.passwordError,_that.confirmPasswordError,_that.isValid);case SubmittingSignUp():
return submitting(_that.email,_that.password,_that.confirmPassword);case SuccessSignUp():
return success();case FailureSignUp():
return failure(_that.errorMessage,_that.email,_that.password,_that.confirmPassword,_that.emailError,_that.passwordError,_that.confirmPasswordError,_that.isValid);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password,  String confirmPassword,  String? emailError,  String? passwordError,  String? confirmPasswordError,  bool isValid)?  input,TResult? Function( String email,  String password,  String confirmPassword)?  submitting,TResult? Function()?  success,TResult? Function( String errorMessage,  String email,  String password,  String confirmPassword,  String? emailError,  String? passwordError,  String? confirmPasswordError,  bool isValid)?  failure,}) {final _that = this;
switch (_that) {
case InputSignUp() when input != null:
return input(_that.email,_that.password,_that.confirmPassword,_that.emailError,_that.passwordError,_that.confirmPasswordError,_that.isValid);case SubmittingSignUp() when submitting != null:
return submitting(_that.email,_that.password,_that.confirmPassword);case SuccessSignUp() when success != null:
return success();case FailureSignUp() when failure != null:
return failure(_that.errorMessage,_that.email,_that.password,_that.confirmPassword,_that.emailError,_that.passwordError,_that.confirmPasswordError,_that.isValid);case _:
  return null;

}
}

}

/// @nodoc


class InputSignUp implements SignUpState {
  const InputSignUp({this.email = '', this.password = '', this.confirmPassword = '', this.emailError, this.passwordError, this.confirmPasswordError, this.isValid = false});
  

@JsonKey() final  String email;
@JsonKey() final  String password;
@JsonKey() final  String confirmPassword;
 final  String? emailError;
 final  String? passwordError;
 final  String? confirmPasswordError;
@JsonKey() final  bool isValid;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputSignUpCopyWith<InputSignUp> get copyWith => _$InputSignUpCopyWithImpl<InputSignUp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputSignUp&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword,emailError,passwordError,confirmPasswordError,isValid);

@override
String toString() {
  return 'SignUpState.input(email: $email, password: $password, confirmPassword: $confirmPassword, emailError: $emailError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $InputSignUpCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $InputSignUpCopyWith(InputSignUp value, $Res Function(InputSignUp) _then) = _$InputSignUpCopyWithImpl;
@useResult
$Res call({
 String email, String password, String confirmPassword, String? emailError, String? passwordError, String? confirmPasswordError, bool isValid
});




}
/// @nodoc
class _$InputSignUpCopyWithImpl<$Res>
    implements $InputSignUpCopyWith<$Res> {
  _$InputSignUpCopyWithImpl(this._self, this._then);

  final InputSignUp _self;
  final $Res Function(InputSignUp) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? confirmPassword = null,Object? emailError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? isValid = null,}) {
  return _then(InputSignUp(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SubmittingSignUp implements SignUpState {
  const SubmittingSignUp({required this.email, required this.password, required this.confirmPassword});
  

 final  String email;
 final  String password;
 final  String confirmPassword;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmittingSignUpCopyWith<SubmittingSignUp> get copyWith => _$SubmittingSignUpCopyWithImpl<SubmittingSignUp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmittingSignUp&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,confirmPassword);

@override
String toString() {
  return 'SignUpState.submitting(email: $email, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $SubmittingSignUpCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $SubmittingSignUpCopyWith(SubmittingSignUp value, $Res Function(SubmittingSignUp) _then) = _$SubmittingSignUpCopyWithImpl;
@useResult
$Res call({
 String email, String password, String confirmPassword
});




}
/// @nodoc
class _$SubmittingSignUpCopyWithImpl<$Res>
    implements $SubmittingSignUpCopyWith<$Res> {
  _$SubmittingSignUpCopyWithImpl(this._self, this._then);

  final SubmittingSignUp _self;
  final $Res Function(SubmittingSignUp) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? confirmPassword = null,}) {
  return _then(SubmittingSignUp(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SuccessSignUp implements SignUpState {
  const SuccessSignUp();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessSignUp);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignUpState.success()';
}


}




/// @nodoc


class FailureSignUp implements SignUpState {
  const FailureSignUp({required this.errorMessage, required this.email, required this.password, required this.confirmPassword, this.emailError, this.passwordError, this.confirmPasswordError, this.isValid = false});
  

 final  String errorMessage;
 final  String email;
 final  String password;
 final  String confirmPassword;
 final  String? emailError;
 final  String? passwordError;
 final  String? confirmPasswordError;
@JsonKey() final  bool isValid;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureSignUpCopyWith<FailureSignUp> get copyWith => _$FailureSignUpCopyWithImpl<FailureSignUp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureSignUp&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,email,password,confirmPassword,emailError,passwordError,confirmPasswordError,isValid);

@override
String toString() {
  return 'SignUpState.failure(errorMessage: $errorMessage, email: $email, password: $password, confirmPassword: $confirmPassword, emailError: $emailError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $FailureSignUpCopyWith<$Res> implements $SignUpStateCopyWith<$Res> {
  factory $FailureSignUpCopyWith(FailureSignUp value, $Res Function(FailureSignUp) _then) = _$FailureSignUpCopyWithImpl;
@useResult
$Res call({
 String errorMessage, String email, String password, String confirmPassword, String? emailError, String? passwordError, String? confirmPasswordError, bool isValid
});




}
/// @nodoc
class _$FailureSignUpCopyWithImpl<$Res>
    implements $FailureSignUpCopyWith<$Res> {
  _$FailureSignUpCopyWithImpl(this._self, this._then);

  final FailureSignUp _self;
  final $Res Function(FailureSignUp) _then;

/// Create a copy of SignUpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,Object? email = null,Object? password = null,Object? confirmPassword = null,Object? emailError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? isValid = null,}) {
  return _then(FailureSignUp(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
