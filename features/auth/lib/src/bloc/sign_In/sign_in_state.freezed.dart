// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState()';
}


}

/// @nodoc
class $SignInStateCopyWith<$Res>  {
$SignInStateCopyWith(SignInState _, $Res Function(SignInState) __);
}


/// Adds pattern-matching-related methods to [SignInState].
extension SignInStatePatterns on SignInState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InputSignIn value)?  input,TResult Function( SubmittingSignIn value)?  submitting,TResult Function( SuccessSignIn value)?  success,TResult Function( FailureSignIn value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InputSignIn() when input != null:
return input(_that);case SubmittingSignIn() when submitting != null:
return submitting(_that);case SuccessSignIn() when success != null:
return success(_that);case FailureSignIn() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InputSignIn value)  input,required TResult Function( SubmittingSignIn value)  submitting,required TResult Function( SuccessSignIn value)  success,required TResult Function( FailureSignIn value)  failure,}){
final _that = this;
switch (_that) {
case InputSignIn():
return input(_that);case SubmittingSignIn():
return submitting(_that);case SuccessSignIn():
return success(_that);case FailureSignIn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InputSignIn value)?  input,TResult? Function( SubmittingSignIn value)?  submitting,TResult? Function( SuccessSignIn value)?  success,TResult? Function( FailureSignIn value)?  failure,}){
final _that = this;
switch (_that) {
case InputSignIn() when input != null:
return input(_that);case SubmittingSignIn() when submitting != null:
return submitting(_that);case SuccessSignIn() when success != null:
return success(_that);case FailureSignIn() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String password,  String? emailError,  String? passwordError,  bool isValid)?  input,TResult Function( String email,  String password)?  submitting,TResult Function()?  success,TResult Function( String email,  String password,  String errorMessage)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InputSignIn() when input != null:
return input(_that.email,_that.password,_that.emailError,_that.passwordError,_that.isValid);case SubmittingSignIn() when submitting != null:
return submitting(_that.email,_that.password);case SuccessSignIn() when success != null:
return success();case FailureSignIn() when failure != null:
return failure(_that.email,_that.password,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String password,  String? emailError,  String? passwordError,  bool isValid)  input,required TResult Function( String email,  String password)  submitting,required TResult Function()  success,required TResult Function( String email,  String password,  String errorMessage)  failure,}) {final _that = this;
switch (_that) {
case InputSignIn():
return input(_that.email,_that.password,_that.emailError,_that.passwordError,_that.isValid);case SubmittingSignIn():
return submitting(_that.email,_that.password);case SuccessSignIn():
return success();case FailureSignIn():
return failure(_that.email,_that.password,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String password,  String? emailError,  String? passwordError,  bool isValid)?  input,TResult? Function( String email,  String password)?  submitting,TResult? Function()?  success,TResult? Function( String email,  String password,  String errorMessage)?  failure,}) {final _that = this;
switch (_that) {
case InputSignIn() when input != null:
return input(_that.email,_that.password,_that.emailError,_that.passwordError,_that.isValid);case SubmittingSignIn() when submitting != null:
return submitting(_that.email,_that.password);case SuccessSignIn() when success != null:
return success();case FailureSignIn() when failure != null:
return failure(_that.email,_that.password,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class InputSignIn implements SignInState {
  const InputSignIn({this.email = '', this.password = '', this.emailError, this.passwordError, this.isValid = false});
  

@JsonKey() final  String email;
@JsonKey() final  String password;
 final  String? emailError;
 final  String? passwordError;
@JsonKey() final  bool isValid;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputSignInCopyWith<InputSignIn> get copyWith => _$InputSignInCopyWithImpl<InputSignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputSignIn&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.isValid, isValid) || other.isValid == isValid));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,emailError,passwordError,isValid);

@override
String toString() {
  return 'SignInState.input(email: $email, password: $password, emailError: $emailError, passwordError: $passwordError, isValid: $isValid)';
}


}

/// @nodoc
abstract mixin class $InputSignInCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory $InputSignInCopyWith(InputSignIn value, $Res Function(InputSignIn) _then) = _$InputSignInCopyWithImpl;
@useResult
$Res call({
 String email, String password, String? emailError, String? passwordError, bool isValid
});




}
/// @nodoc
class _$InputSignInCopyWithImpl<$Res>
    implements $InputSignInCopyWith<$Res> {
  _$InputSignInCopyWithImpl(this._self, this._then);

  final InputSignIn _self;
  final $Res Function(InputSignIn) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? emailError = freezed,Object? passwordError = freezed,Object? isValid = null,}) {
  return _then(InputSignIn(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SubmittingSignIn implements SignInState {
  const SubmittingSignIn({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmittingSignInCopyWith<SubmittingSignIn> get copyWith => _$SubmittingSignInCopyWithImpl<SubmittingSignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmittingSignIn&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'SignInState.submitting(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $SubmittingSignInCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory $SubmittingSignInCopyWith(SubmittingSignIn value, $Res Function(SubmittingSignIn) _then) = _$SubmittingSignInCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$SubmittingSignInCopyWithImpl<$Res>
    implements $SubmittingSignInCopyWith<$Res> {
  _$SubmittingSignInCopyWithImpl(this._self, this._then);

  final SubmittingSignIn _self;
  final $Res Function(SubmittingSignIn) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(SubmittingSignIn(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SuccessSignIn implements SignInState {
  const SuccessSignIn();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SuccessSignIn);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignInState.success()';
}


}




/// @nodoc


class FailureSignIn implements SignInState {
  const FailureSignIn({required this.email, required this.password, required this.errorMessage});
  

 final  String email;
 final  String password;
 final  String errorMessage;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureSignInCopyWith<FailureSignIn> get copyWith => _$FailureSignInCopyWithImpl<FailureSignIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FailureSignIn&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,errorMessage);

@override
String toString() {
  return 'SignInState.failure(email: $email, password: $password, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FailureSignInCopyWith<$Res> implements $SignInStateCopyWith<$Res> {
  factory $FailureSignInCopyWith(FailureSignIn value, $Res Function(FailureSignIn) _then) = _$FailureSignInCopyWithImpl;
@useResult
$Res call({
 String email, String password, String errorMessage
});




}
/// @nodoc
class _$FailureSignInCopyWithImpl<$Res>
    implements $FailureSignInCopyWith<$Res> {
  _$FailureSignInCopyWithImpl(this._self, this._then);

  final FailureSignIn _self;
  final $Res Function(FailureSignIn) _then;

/// Create a copy of SignInState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? errorMessage = null,}) {
  return _then(FailureSignIn(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
