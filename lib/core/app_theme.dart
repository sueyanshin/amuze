// ==============================================================================
// PanelVerse Theme Configuration (Light & Dark Theme)
// Compatible with Flutter 3.x / Material 3 (ThemeData & ColorScheme)
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide custom colors and brand tokens for PanelVerse
class AppColors {
  // Brand Accents
  static const Color electricCyan = Color(0xFF38BDF8);
  static const Color deepElectricBlue = Color(0xFF0066FF);
  static const Color neonCrimson = Color(0xFFFF2A55);
  static const Color comicAmber = Color(0xFFFFB800);
  static const Color spoilerBorder = Color(0xFFEF4444);

  // Dark Theme Palette (From DESIGN_SYSTEM_1: PanelVerse Graphic Dark)
  static const Color darkCanvas = Color(0xFF0B0F19);
  static const Color darkSurface = Color(0xFF0F131D);
  static const Color darkSurfaceCard = Color(0xFF131927);
  static const Color darkSurfaceContainerHigh = Color(0xFF1A2234);
  static const Color darkBorder = Color(0xFF222D42);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Light Theme Palette (From DESIGN_SYSTEM_2: Graphic Social Ink)
  static const Color lightCanvas = Color(0xFFF4F6FB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceLow = Color(0xFFF1F3FF);
  static const Color lightSurfaceContainerHigh = Color(0xFFE8ECF8);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);
}

/// Custom ThemeExtension for PanelVerse comic-specific design tokens
class PanelVerseThemeExtension
    extends ThemeExtension<PanelVerseThemeExtension> {
  final Color spoilerBackground;
  final Color spoilerBorder;
  final Color spoilerText;
  final Color reactionPillBackground;
  final Color reactionPillBorder;
  final Color clipPanelButtonBackground;
  final Color clipPanelButtonForeground;
  final Color pollFillColor;
  final Color pollTrackColor;
  final double cardBorderRadius;

  const PanelVerseThemeExtension({
    required this.spoilerBackground,
    required this.spoilerBorder,
    required this.spoilerText,
    required this.reactionPillBackground,
    required this.reactionPillBorder,
    required this.clipPanelButtonBackground,
    required this.clipPanelButtonForeground,
    required this.pollFillColor,
    required this.pollTrackColor,
    this.cardBorderRadius = 16.0,
  });

  @override
  ThemeExtension<PanelVerseThemeExtension> copyWith({
    Color? spoilerBackground,
    Color? spoilerBorder,
    Color? spoilerText,
    Color? reactionPillBackground,
    Color? reactionPillBorder,
    Color? clipPanelButtonBackground,
    Color? clipPanelButtonForeground,
    Color? pollFillColor,
    Color? pollTrackColor,
    double? cardBorderRadius,
  }) {
    return PanelVerseThemeExtension(
      spoilerBackground: spoilerBackground ?? this.spoilerBackground,
      spoilerBorder: spoilerBorder ?? this.spoilerBorder,
      spoilerText: spoilerText ?? this.spoilerText,
      reactionPillBackground:
          reactionPillBackground ?? this.reactionPillBackground,
      reactionPillBorder: reactionPillBorder ?? this.reactionPillBorder,
      clipPanelButtonBackground:
          clipPanelButtonBackground ?? this.clipPanelButtonBackground,
      clipPanelButtonForeground:
          clipPanelButtonForeground ?? this.clipPanelButtonForeground,
      pollFillColor: pollFillColor ?? this.pollFillColor,
      pollTrackColor: pollTrackColor ?? this.pollTrackColor,
      cardBorderRadius: cardBorderRadius ?? this.cardBorderRadius,
    );
  }

  @override
  ThemeExtension<PanelVerseThemeExtension> lerp(
    covariant ThemeExtension<PanelVerseThemeExtension>? other,
    double t,
  ) {
    if (other is! PanelVerseThemeExtension) return this;
    return PanelVerseThemeExtension(
      spoilerBackground: Color.lerp(
        spoilerBackground,
        other.spoilerBackground,
        t,
      )!,
      spoilerBorder: Color.lerp(spoilerBorder, other.spoilerBorder, t)!,
      spoilerText: Color.lerp(spoilerText, other.spoilerText, t)!,
      reactionPillBackground: Color.lerp(
        reactionPillBackground,
        other.reactionPillBackground,
        t,
      )!,
      reactionPillBorder: Color.lerp(
        reactionPillBorder,
        other.reactionPillBorder,
        t,
      )!,
      clipPanelButtonBackground: Color.lerp(
        clipPanelButtonBackground,
        other.clipPanelButtonBackground,
        t,
      )!,
      clipPanelButtonForeground: Color.lerp(
        clipPanelButtonForeground,
        other.clipPanelButtonForeground,
        t,
      )!,
      pollFillColor: Color.lerp(pollFillColor, other.pollFillColor, t)!,
      pollTrackColor: Color.lerp(pollTrackColor, other.pollTrackColor, t)!,
      cardBorderRadius:
          cardBorderRadius + (other.cardBorderRadius - cardBorderRadius) * t,
    );
  }

  static const dark = PanelVerseThemeExtension(
    spoilerBackground: Color(0x26EF4444), // red with opacity
    spoilerBorder: Color(0x66EF4444),
    spoilerText: Color(0xFFFCA5A5),
    reactionPillBackground: Color(0xCC0F172A),
    reactionPillBorder: Color(0xFF334155),
    clipPanelButtonBackground: AppColors.electricCyan,
    clipPanelButtonForeground: Color(0xFF0F172A),
    pollFillColor: Color(0xFF0284C7),
    pollTrackColor: Color(0xFF1E293B),
    cardBorderRadius: 16.0,
  );

  static const light = PanelVerseThemeExtension(
    spoilerBackground: Color(0xFFFEF2F2),
    spoilerBorder: Color(0xFFFCA5A5),
    spoilerText: Color(0xFFDC2626),
    reactionPillBackground: Color(0xE6FFFFFF),
    reactionPillBorder: Color(0xFFCBD5E1),
    clipPanelButtonBackground: AppColors.deepElectricBlue,
    clipPanelButtonForeground: Colors.white,
    pollFillColor: Color(0xFFDBEAFE),
    pollTrackColor: Color(0xFFF1F5F9),
    cardBorderRadius: 16.0,
  );
}

/// Main Theme Definitions
class AppTheme {
  // Shared Typography using GoogleFonts Space Grotesk
  // static TextTheme _buildTextTheme(Color primary, Color secondary, Color muted) {
  //   final base = GoogleFonts.spaceGroteskTextTheme();
  //   return base.copyWith(
  //     displayLarge: base.displayLarge?.copyWith(
  //       color: primary,
  //       fontWeight: FontWeight.w700,
  //       letterSpacing: -0.5,
  //     ),
  //     headlineMedium: base.headlineMedium?.copyWith(
  //       color: primary,
  //       fontWeight: FontWeight.w700,
  //       letterSpacing: -0.2,
  //     ),
  //     headlineSmall: base.headlineSmall?.copyWith(
  //       color: primary,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     titleMedium: base.titleMedium?.copyWith(
  //       color: primary,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     bodyLarge: base.bodyLarge?.copyWith(
  //       color: primary,
  //       height: 1.5,
  //     ),
  //     bodyMedium: base.bodyMedium?.copyWith(
  //       color: secondary,
  //       height: 1.4,
  //     ),
  //     bodySmall: base.bodySmall?.copyWith(
  //       color: muted,
  //       fontSize: 12,
  //     ),
  //     labelLarge: base.labelLarge?.copyWith(
  //       color: primary,
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }

  static TextTheme _buildTextTheme(
    Color primary,
    Color secondary,
    Color muted,
  ) {
    // Use the standard Material 3 geometry and baseline text styles
    final base =
        Typography.material2021().black; // or .white depending on your theme

    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: primary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: primary, height: 1.5),
      bodyMedium: base.bodyMedium?.copyWith(color: secondary, height: 1.4),
      bodySmall: base.bodySmall?.copyWith(color: muted, fontSize: 12),
      labelLarge: base.labelLarge?.copyWith(
        color: primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // ============================================================================
  // LIGHT THEME
  // ============================================================================
  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme.light(
      primary: AppColors.deepElectricBlue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE0EDFF),
      onPrimaryContainer: Color(0xFF003D99),
      secondary: AppColors.electricCyan,
      onSecondary: Colors.white,
      tertiary: AppColors.neonCrimson,
      onTertiary: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      surfaceContainerHighest: AppColors.lightSurfaceContainerHigh,
      outline: AppColors.lightBorder,
      outlineVariant: Color(0xFFE2E8F0),
      error: Color(0xFFDC2626),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightCanvas,
      textTheme: _buildTextTheme(
        AppColors.lightTextPrimary,
        AppColors.lightTextSecondary,
        AppColors.lightTextMuted,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        elevation: 3,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.deepElectricBlue,
            );
          }
          return GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.lightTextSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.deepElectricBlue);
          }
          return const IconThemeData(color: AppColors.lightTextSecondary);
        }),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.deepElectricBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: StadiumBorder(),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        PanelVerseThemeExtension.light,
      ],
    );
  }

  // ============================================================================
  // DARK THEME
  // ============================================================================
  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme.dark(
      primary: AppColors.electricCyan,
      onPrimary: Color(0xFF082F49),
      primaryContainer: Color(0xFF0369A1),
      onPrimaryContainer: Color(0xFFE0F2FE),
      secondary: AppColors.deepElectricBlue,
      onSecondary: Colors.white,
      tertiary: AppColors.neonCrimson,
      onTertiary: Colors.white,
      surface: AppColors.darkSurfaceCard,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurfaceContainerHigh,
      outline: AppColors.darkBorder,
      outlineVariant: Color(0xFF1E293B),
      error: Color(0xFFEF4444),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkCanvas,
      textTheme: _buildTextTheme(
        AppColors.darkTextPrimary,
        AppColors.darkTextSecondary,
        AppColors.darkTextMuted,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.spaceGrotesk(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.darkTextPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        indicatorColor: AppColors.electricCyan.withValues(alpha: 0.15),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.spaceGrotesk(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.electricCyan,
            );
          }
          return GoogleFonts.spaceGrotesk(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.darkTextMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.electricCyan);
          }
          return const IconThemeData(color: AppColors.darkTextMuted);
        }),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.electricCyan,
        foregroundColor: Color(0xFF0F172A),
        elevation: 6,
        shape: StadiumBorder(),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        PanelVerseThemeExtension.dark,
      ],
    );
  }
}
