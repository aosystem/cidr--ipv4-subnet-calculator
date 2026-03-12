import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:cidr/l10n/app_localizations.dart';
import 'package:cidr/home_page.dart';
import 'package:cidr/model.dart';
import 'package:cidr/theme_mode_number.dart';
import 'package:cidr/parse_locale_tag.dart';
import 'package:cidr/loading_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false,
    systemStatusBarContrastEnforced: false,
  ));
  MobileAds.instance.initialize();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.light;
  Locale? locale;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initState();
  }

  void _initState() async {
    try {
      await Model.ensureReady();
      themeMode = ThemeModeNumber.numberToThemeMode(Model.themeNumber);
      locale = parseLocaleTag(Model.languageCode);
    } catch (e) {
    } finally {
      if (mounted) {
        setState(() {
          _isReady = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const seed = Colors.purple;
    final colorSchemeLight = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
    final colorSchemeDark = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);
    IconThemeData buildIconTheme(ColorScheme colors) => IconThemeData(
      color: colors.primary,
      size: 24,
    );
    final commonElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
    final commonSliderTheme = SliderThemeData(
      activeTrackColor: null,
      thumbColor: null,
      showValueIndicator: ShowValueIndicator.onDrag,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
      valueIndicatorTextStyle: TextStyle(color: Colors.black),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
        sliderTheme: commonSliderTheme,
        elevatedButtonTheme: commonElevatedButtonTheme,
        iconTheme: buildIconTheme(colorSchemeLight),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
        sliderTheme: commonSliderTheme,
        elevatedButtonTheme: commonElevatedButtonTheme,
        iconTheme: buildIconTheme(colorSchemeDark),
      ),
      home: _isReady ? const MainHomePage() : const LoadingScreen(),
    );
  }
}
