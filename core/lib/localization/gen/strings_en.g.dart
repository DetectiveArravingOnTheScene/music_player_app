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

	/// en: 'Retry'
	String get retry => 'Retry';

	late final TranslationsErrorEn error = TranslationsErrorEn._(_root);
	late final TranslationsLoginEn login = TranslationsLoginEn._(_root);
	late final TranslationsTrackEn track = TranslationsTrackEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
}

// Path: error
class TranslationsErrorEn {
	TranslationsErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong'
	String get generalError => 'Something went wrong';
}

// Path: login
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign In'
	String get signIn => 'Sign In';

	/// en: 'Sign Up'
	String get signUp => 'Sign Up';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirmPassword => 'Confirm Password';

	late final TranslationsLoginEmailErrorEn emailError = TranslationsLoginEmailErrorEn._(_root);
	late final TranslationsLoginPasswordErrorEn passwordError = TranslationsLoginPasswordErrorEn._(_root);
	late final TranslationsLoginConfirmPasswordErrorEn confirmPasswordError = TranslationsLoginConfirmPasswordErrorEn._(_root);

	/// en: 'Logged in successfully'
	String get success => 'Logged in successfully';

	/// en: 'Logged in failed'
	String get fail => 'Logged in failed';

	/// en: 'or continue with'
	String get orContinue => 'or continue with';

	/// en: 'Already have an account?'
	String get haveAccount => 'Already have an account?';

	/// en: 'Don't have an account?'
	String get haveNoAccount => 'Don\'t have an account?';

	/// en: 'Google'
	String get google => 'Google';
}

// Path: track
class TranslationsTrackEn {
	TranslationsTrackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to fetch track'
	String get failedToFetch => 'Failed to fetch track';

	/// en: 'Failed to stream track'
	String get failedToStream => 'Failed to stream track';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Trending Tracks'
	String get trendingTracks => 'Trending Tracks';
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

	/// en: 'Password must contain at least one special symbol'
	String get noSpecial => 'Password must contain at least one special symbol';
}

// Path: login.confirmPasswordError
class TranslationsLoginConfirmPasswordErrorEn {
	TranslationsLoginConfirmPasswordErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please confirm your password'
	String get empty => 'Please confirm your password';

	/// en: 'Passwords do not match'
	String get mismatch => 'Passwords do not match';
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
			'retry' => 'Retry',
			'error.generalError' => 'Something went wrong',
			'login.signIn' => 'Sign In',
			'login.signUp' => 'Sign Up',
			'login.email' => 'Email',
			'login.password' => 'Password',
			'login.confirmPassword' => 'Confirm Password',
			'login.emailError.empty' => 'Please enter an email address',
			'login.emailError.invalid' => 'Please enter a valid email address',
			'login.passwordError.empty' => 'Please enter a password',
			'login.passwordError.short' => 'Password must be at least 8 characters long',
			'login.passwordError.noUppercase' => 'Password must contain at least one uppercase letter',
			'login.passwordError.noNumber' => 'Password must contain at least one number',
			'login.passwordError.noSpecial' => 'Password must contain at least one special symbol',
			'login.confirmPasswordError.empty' => 'Please confirm your password',
			'login.confirmPasswordError.mismatch' => 'Passwords do not match',
			'login.success' => 'Logged in successfully',
			'login.fail' => 'Logged in failed',
			'login.orContinue' => 'or continue with',
			'login.haveAccount' => 'Already have an account?',
			'login.haveNoAccount' => 'Don\'t have an account?',
			'login.google' => 'Google',
			'track.failedToFetch' => 'Failed to fetch track',
			'track.failedToStream' => 'Failed to stream track',
			'home.trendingTracks' => 'Trending Tracks',
			_ => null,
		};
	}
}
