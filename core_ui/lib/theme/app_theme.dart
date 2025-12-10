import 'package:flutter/material.dart';

class AppTheme {
  static final ColorScheme _lightScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkScheme = ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  );

  static InputDecorationTheme _buildInputDecorationTheme(ColorScheme scheme) {
    return InputDecorationTheme(
      filled: false,
      contentPadding: const EdgeInsets.all(8),

      floatingLabelStyle: WidgetStateTextStyle.resolveWith((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.error)) {
          return TextStyle(color: scheme.error);
        }
        if (states.contains(WidgetState.focused)) {
          return TextStyle(color: scheme.primary);
        }
        return TextStyle(color: scheme.onSurfaceVariant);
      }),

      labelStyle: TextStyle(color: scheme.onSurfaceVariant),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: scheme.outline, width: 1.0),
      ),

      // Focused Border
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: scheme.primary, width: 2.0),
      ),

      // Error Border
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: scheme.error, width: 1.0),
      ),

      // Focused Error Border
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(color: scheme.error, width: 2.0),
      ),

      // Disabled Border
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide(
          color: scheme.onSurface.withValues(alpha: 0.12),
          width: 1.0,
        ),
      ),
    );
  }

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightScheme,
    inputDecorationTheme: _buildInputDecorationTheme(_lightScheme),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: _darkScheme,
    inputDecorationTheme: _buildInputDecorationTheme(_darkScheme),
  );
}
