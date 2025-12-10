///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override String hello({required Object name}) => 'Привет, ${name}';
	@override String get save => 'Сохранить';
	@override late final _TranslationsErrorRu error = _TranslationsErrorRu._(_root);
	@override late final _TranslationsLoginRu login = _TranslationsLoginRu._(_root);
}

// Path: error
class _TranslationsErrorRu implements TranslationsErrorEn {
	_TranslationsErrorRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get generalError => 'Что-то пошло не так';
}

// Path: login
class _TranslationsLoginRu implements TranslationsLoginEn {
	_TranslationsLoginRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get signIn => 'Войти';
	@override String get signUp => 'Зарегистироваться';
	@override String get email => 'Электронная почта';
	@override String get confirmPassword => 'Подтвердите пароль';
	@override String get password => 'Пароль';
	@override late final _TranslationsLoginEmailErrorRu emailError = _TranslationsLoginEmailErrorRu._(_root);
	@override late final _TranslationsLoginPasswordErrorRu passwordError = _TranslationsLoginPasswordErrorRu._(_root);
	@override late final _TranslationsLoginConfirmPasswordErrorRu confirmPasswordError = _TranslationsLoginConfirmPasswordErrorRu._(_root);
	@override String get success => 'Вход выполнен успешно';
	@override String get fail => 'Не удалось войти';
	@override String get orContinue => 'или войдите с помощью';
	@override String get haveAccount => 'Уже есть аккаунт?';
	@override String get haveNoAccount => 'Еще нет аккаунта?';
	@override String get google => 'Google';
}

// Path: login.emailError
class _TranslationsLoginEmailErrorRu implements TranslationsLoginEmailErrorEn {
	_TranslationsLoginEmailErrorRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Пожалуйста, введите адрес электронной почты';
	@override String get invalid => 'Пожалуйста, введите корректный адрес электронной почты';
}

// Path: login.passwordError
class _TranslationsLoginPasswordErrorRu implements TranslationsLoginPasswordErrorEn {
	_TranslationsLoginPasswordErrorRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Пожалуйста, введите пароль';
	@override String get short => 'Пароль должен содержать минимум 8 символов';
	@override String get noUppercase => 'Пароль должен содержать хотя бы одну заглавную букву';
	@override String get noNumber => 'Пароль должен содержать хотя бы одну цифру';
	@override String get noSpecial => 'Пароль должен содержать хотя бы один специальный символ';
}

// Path: login.confirmPasswordError
class _TranslationsLoginConfirmPasswordErrorRu implements TranslationsLoginConfirmPasswordErrorEn {
	_TranslationsLoginConfirmPasswordErrorRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get empty => 'Пожалуйста, подтвердите пароль';
	@override String get mismatch => 'Пароли не совпадают';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'hello' => ({required Object name}) => 'Привет, ${name}',
			'save' => 'Сохранить',
			'error.generalError' => 'Что-то пошло не так',
			'login.signIn' => 'Войти',
			'login.signUp' => 'Зарегистироваться',
			'login.email' => 'Электронная почта',
			'login.confirmPassword' => 'Подтвердите пароль',
			'login.password' => 'Пароль',
			'login.emailError.empty' => 'Пожалуйста, введите адрес электронной почты',
			'login.emailError.invalid' => 'Пожалуйста, введите корректный адрес электронной почты',
			'login.passwordError.empty' => 'Пожалуйста, введите пароль',
			'login.passwordError.short' => 'Пароль должен содержать минимум 8 символов',
			'login.passwordError.noUppercase' => 'Пароль должен содержать хотя бы одну заглавную букву',
			'login.passwordError.noNumber' => 'Пароль должен содержать хотя бы одну цифру',
			'login.passwordError.noSpecial' => 'Пароль должен содержать хотя бы один специальный символ',
			'login.confirmPasswordError.empty' => 'Пожалуйста, подтвердите пароль',
			'login.confirmPasswordError.mismatch' => 'Пароли не совпадают',
			'login.success' => 'Вход выполнен успешно',
			'login.fail' => 'Не удалось войти',
			'login.orContinue' => 'или войдите с помощью',
			'login.haveAccount' => 'Уже есть аккаунт?',
			'login.haveNoAccount' => 'Еще нет аккаунта?',
			'login.google' => 'Google',
			_ => null,
		};
	}
}
