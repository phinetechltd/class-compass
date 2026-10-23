import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/theme_controller.dart';
import 'package:class_compass/util/dimensions.dart';

const sfProLight = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w300,
);

const textRegular = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w400,
);

const textMedium = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w500,
);

const textSemiBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

const textBold = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w700,
);

const textHeavy = TextStyle(
  fontFamily: 'Inter',
  fontWeight: FontWeight.w900,
);

/// Modern color palette - Tari Africa brand colors
class AppColors {
  /// Primary brand color - Deep Navy Blue
  static const Color primary = Color(0xFF0F172A);
  static const Color primaryDark = Color(0xFF020617);
  static const Color primaryLight = Color(0xFF1E293B);

  /// Secondary - Vibrant Teal/Cyan
  static const Color secondary = Color(0xFF06B6D4);
  static const Color secondaryDark = Color(0xFF0891B2);
  static const Color secondaryLight = Color(0xFF22D3EE);

  /// Accent - Emerald Green
  static const Color accent = Color(0xFF10B981);
  static const Color accentDark = Color(0xFF059669);
  static const Color accentLight = Color(0xFF34D399);

  /// Warning - Amber
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFD97706);

  /// Error - Rose/Red
  static const Color error = Color(0xFFEF4444);
  static const Color errorDark = Color(0xFFDC2626);

  /// Success - Green
  static const Color success = Color(0xFF22C55E);
  static const Color successDark = Color(0xFF16A34A);

  /// Neutral grays
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  static const Color card = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF020617);
  static const Color darkSurface = Color(0xFF0F172A);
  
  /// Text colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textInverse = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF94A3B8);

  /// Border colors
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderMedium = Color(0xFFCBD5E1);
  static const Color borderDark = Color(0xFF94A3B8);

  /// Overlay
  static const Color overlayLight = Color(0xFF000000);
  static const Color overlayDark = Color(0xFF000000);

  /// Get theme color based on current theme mode
  static Color get primaryColor => Get.find<ThemeController>().darkTheme ? primaryLight : primary;
  static Color get secondaryColor => Get.find<ThemeController>().darkTheme ? secondaryLight : secondary;
  static Color get accentColor => Get.find<ThemeController>().darkTheme ? accentLight : accent;
  static Color get backgroundColor => Get.find<ThemeController>().darkTheme ? const Color(0xFF020617) : background;
  static Color get surfaceColor => Get.find<ThemeController>().darkTheme ? const Color(0xFF0F172A) : surface;
  static Color get textPrimaryColor => Get.find<ThemeController>().darkTheme ? textInverse : textPrimary;
  static Color get textSecondaryColor => Get.find<ThemeController>().darkTheme ? textMuted : textSecondary;
  static Color get textTertiaryColor => Get.find<ThemeController>().darkTheme ? textMuted : textTertiary;
  static Color get borderColor => Get.find<ThemeController>().darkTheme ? borderDark : borderLight;

  /// Generate MaterialColor from a single color
  static MaterialColor createMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: color.withValues(alpha: 0.1),
      100: color.withValues(alpha: 0.2),
      200: color.withValues(alpha: 0.3),
      300: color.withValues(alpha: 0.4),
      400: color.withValues(alpha: 0.5),
      500: color,
      600: color,
      700: color,
      800: color,
      900: color,
    });
  }
}

/// Modern shadow system
class AppShadows {
  static const List<BoxShadow> light = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> heavy = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16,
      offset: Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> colored = [
    BoxShadow(
      color: Color(0x220F172A),
      blurRadius: 20,
      offset: Offset(0, 10),
      spreadRadius: 0,
    ),
  ];
}

/// ThemeShadow (legacy compatibility)
class ThemeShadow {
  static List <BoxShadow> getShadow() {
    return AppShadows.light;
  }
  static BoxDecoration? getDecoration({Color? color, Color? shadowColor} ) {
    return BoxDecoration(
        color: color?? AppColors.primary,
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        boxShadow:  [BoxShadow(color: shadowColor?? AppColors.primaryLight, spreadRadius: 1, blurRadius: 0, offset: const Offset(0, 3))]
    );
  }
  static BoxDecoration? getLandingPageDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF081D5F),
          Color(0xFF6D0B9C),
          Color(0xFF2B43A4),
        ],
        begin: Alignment.centerLeft,
        end:  Alignment.centerRight,
      ),
    );
  }
  static EdgeInsetsGeometry getPadding() {
    return EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall);
  }
}

/// Modern border radius system
class AppBorderRadius {
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 14;
  static const double xl = 20;
  static const double full = 9999;
}

/// Modern spacing system
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Modern elevation system
class AppElevation {
  static const double none = 0;
  static const double sm = 1;
  static const double md = 2;
  static const double lg = 4;
  static const double xl = 8;
  static const double xxl = 16;
}

/// Theme extensions for easy access
class AppTheme {
  const AppTheme();

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.background,
      splashFactory: InkRipple.splashFactory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.primary,
        onPrimary: AppColors.textInverse,
        primaryContainer: const Color(0xFFE2E8F0),
        onPrimaryContainer: AppColors.primary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textInverse,
        secondaryContainer: const Color(0xFFCFFAFE),
        onSecondaryContainer: const Color(0xFF155E75),
        tertiary: AppColors.accent,
        onTertiary: AppColors.textInverse,
        tertiaryContainer: const Color(0xFFD1FAE5),
        onTertiaryContainer: const Color(0xFF065F46),
        error: AppColors.error,
        onError: AppColors.textInverse,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.surfaceVariant,
        outline: AppColors.borderLight,
        surfaceTint: Colors.transparent,
        brightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 20),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 32, color: AppColors.textPrimary),
        displayMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.textPrimary),
        displaySmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 24, color: AppColors.textPrimary),
        headlineLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 22, color: AppColors.textPrimary),
        headlineMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.textPrimary),
        headlineSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.textPrimary),
        titleLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textPrimary),
        titleMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textPrimary),
        titleSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textPrimary),
        bodyLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.textSecondary),
        bodyMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.textSecondary),
        bodySmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.textTertiary),
        labelLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textPrimary),
        labelMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textSecondary),
        labelSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 10, color: AppColors.textTertiary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.xl),
          side: const BorderSide(color: AppColors.borderLight),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textInverse,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
          textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
          textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
          ),
          textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primary,
        secondarySelectedColor: AppColors.secondary,
        labelStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12),
        secondaryLabelStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textInverse),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.full)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.borderLight,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
        elevation: AppElevation.xl,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppBorderRadius.lg)),
        ),
        elevation: AppElevation.xxl,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.darkBackground,
      splashFactory: InkRipple.splashFactory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLight,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.textInverse,
        primaryContainer: const Color(0xFF1E293B),
        onPrimaryContainer: AppColors.textInverse,
        secondary: AppColors.secondaryLight,
        onSecondary: const Color(0xFF083344),
        secondaryContainer: const Color(0xFF164E63),
        onSecondaryContainer: const Color(0xFFCFFAFE),
        tertiary: AppColors.accentLight,
        onTertiary: const Color(0xFF022C22),
        tertiaryContainer: const Color(0xFF064E3B),
        onTertiaryContainer: const Color(0xFFD1FAE5),
        error: AppColors.error,
        onError: AppColors.textInverse,
        surface: AppColors.darkSurface,
        onSurface: AppColors.textInverse,
        surfaceContainerHighest: const Color(0xFF1E293B),
        outline: const Color(0xFF334155),
        surfaceTint: Colors.transparent,
        brightness: Brightness.dark,
      ),
      iconTheme: const IconThemeData(color: AppColors.textMuted, size: 20),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 32, color: AppColors.textInverse),
        displayMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.textInverse),
        displaySmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 24, color: AppColors.textInverse),
        headlineLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 22, color: AppColors.textInverse),
        headlineMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 20, color: AppColors.textInverse),
        headlineSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.textInverse),
        titleLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.textInverse),
        titleMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textInverse),
        titleSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 12, color: AppColors.textInverse),
        bodyLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 16, color: AppColors.textMuted),
        bodyMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.textMuted),
        bodySmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.textMuted),
        labelLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textInverse),
        labelMedium: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textMuted),
        labelSmall: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 10, color: AppColors.textMuted),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF1E293B),
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: Color(0xFF334155)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.secondary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.md),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
      cardTheme: CardThemeData(
        color: Color(0xFF0F172A),
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.xl),
          side: const BorderSide(color: Color(0xFF334155)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.textInverse,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
          textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primaryLight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
          ),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
          textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppBorderRadius.md),
          ),
          textStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Color(0xFF1E293B),
        selectedColor: AppColors.primaryLight,
        secondarySelectedColor: AppColors.secondaryLight,
        labelStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12),
        secondaryLabelStyle: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textInverse),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppBorderRadius.full)),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF334155),
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
        ),
        elevation: AppElevation.xl,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppBorderRadius.lg)),
        ),
        elevation: AppElevation.xxl,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0F172A),
        foregroundColor: AppColors.textInverse,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.textInverse),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0F172A),
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}

/// Modern icon system
class AppIcons {
  static const IconData home = Icons.home_rounded;
  static const IconData dashboard = Icons.dashboard_rounded;
  static const IconData school = Icons.school_rounded;
  static const IconData students = Icons.people_rounded;
  static const IconData teachers = Icons.person_add_rounded;
  static const IconData fees = Icons.payments_rounded;
  static const IconData library = Icons.library_books_rounded;
  static const IconData settings = Icons.settings_rounded;
  static const IconData report = Icons.assessment_rounded;
  static const IconData inventory = Icons.inventory_rounded;
  static const IconData supplier = Icons.local_shipping_rounded;
  static const IconData transport = Icons.directions_bus_rounded;
  static const IconData hostel = Icons.bed_rounded;
  static const IconData exam = Icons.assignment_rounded;
  static const IconData attendance = Icons.check_circle_rounded;
  static const IconData finance = Icons.account_balance_wallet_rounded;
  static const IconData cms = Icons.edit_rounded;
  static const IconData users = Icons.supervisor_account_rounded;
  static const IconData zoom = Icons.video_call_rounded;
  static const IconData ai = Icons.smart_toy_rounded;
  static const IconData logout = Icons.logout_rounded;
  static const IconData menu = Icons.menu_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData notification = Icons.notifications_rounded;
  static const IconData calendar = Icons.calendar_today_rounded;
  static const IconData star = Icons.star_rounded;
  static const IconData arrow = Icons.arrow_forward_ios_rounded;
  static const IconData check = Icons.check_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData edit = Icons.edit_rounded;
  static const IconData delete = Icons.delete_rounded;
  static const IconData add = Icons.add_rounded;
  static const IconData filter = Icons.filter_list_rounded;
  static const IconData sort = Icons.sort_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData download = Icons.download_rounded;
  static const IconData upload = Icons.upload_rounded;
  static const IconData share = Icons.share_rounded;
  static const IconData print = Icons.print_rounded;
  static const IconData info = Icons.info_rounded;
  static const IconData warning = Icons.warning_rounded;
  static const IconData help = Icons.help_rounded;
  static const IconData lock = Icons.lock_rounded;
  static const IconData unlock = Icons.lock_open_rounded;
  static const IconData visibility = Icons.visibility_rounded;
  static const IconData visibilityOff = Icons.visibility_off_rounded;
}
