///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Hello $name'
	String hello({required Object name}) => 'Hello ${name}';

	/// en: 'Save'
	String get save => 'Save';

	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsLoginEmailErrorEn emailError = TranslationsLoginEmailErrorEn._(_root);
	late final TranslationsLoginPasswordErrorEn passwordError = TranslationsLoginPasswordErrorEn._(_root);

	/// en: 'Logged in successfully'
	String get success => 'Logged in successfully';

	/// en: 'Logged in failed'
	String get fail => 'Logged in failed';
}

// Path: login.emailError
class TranslationsLoginEmailErrorEn {
	TranslationsLoginEmailErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please enter an email address'
	String get empty => 'Please enter an email address';

	/// en: 'Please enter a valid email address'
	String get invalid => 'Please enter a valid email address';
}

// Path: login.passwordError
class TranslationsLoginPasswordErrorEn {
	TranslationsLoginPasswordErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please enter a password'
	String get empty => 'Please enter a password';

	/// en: 'Password must be at least 8 characters long'
	String get short => 'Password must be at least 8 characters long';

	/// en: 'Password must contain at least one uppercase letter'
	String get noUppercase => 'Password must contain at least one uppercase letter';

	/// en: 'Password must contain at least one number'
	String get noNumber => 'Password must contain at least one number';

	/// en: ''
	String get noSpecial => '';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'hello' => ({required Object name}) => 'Hello ${name}',
			'save' => 'Save',
			'login.emailError.empty' => 'Please enter an email address',
			'login.emailError.invalid' => 'Please enter a valid email address',
			'login.passwordError.empty' => 'Please enter a password',
			'login.passwordError.short' => 'Password must be at least 8 characters long',
			'login.passwordError.noUppercase' => 'Password must contain at least one uppercase letter',
			'login.passwordError.noNumber' => 'Password must contain at least one number',
			'login.passwordError.noSpecial' => '',
			'login.success' => 'Logged in successfully',
			'login.fail' => 'Logged in failed',
			_ => null,
		};
	}
}
