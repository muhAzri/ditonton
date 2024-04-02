import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Constants have correct values', () {
    expect(BASE_IMAGE_URL, equals('https://image.tmdb.org/t/p/w500'));
    expect(kRichBlack, equals(const Color(0xFF000814)));
    expect(kOxfordBlue, equals(const Color(0xFF001D3D)));
    expect(kPrussianBlue, equals(const Color(0xFF003566)));
    expect(kMikadoYellow, equals(const Color(0xFFffc300)));
    expect(kDavysGrey, equals(const Color(0xFF4B5358)));
    expect(kGrey, equals(const Color(0xFF303030)));
  });

  test('Text Styles are correctly defined', () {
    expect(kHeading5,
        equals(GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400)));
    expect(
        kHeading6,
        equals(GoogleFonts.poppins(
            fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15)));
    expect(
        kSubtitle,
        equals(GoogleFonts.poppins(
            fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15)));
    expect(
        kBodyText,
        equals(GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25)));
  });

  test('Text Theme is correctly defined', () {
    expect(kTextTheme.headlineSmall, equals(kHeading5));
    expect(kTextTheme.titleLarge, equals(kHeading6));
    expect(kTextTheme.titleMedium, equals(kSubtitle));
    expect(kTextTheme.bodyMedium, equals(kBodyText));
  });

  test('Color Scheme is correctly defined', () {
    expect(kColorScheme.primary, equals(kMikadoYellow));
    expect(kColorScheme.primaryContainer, equals(kMikadoYellow));
    expect(kColorScheme.secondary, equals(kPrussianBlue));
    expect(kColorScheme.secondaryContainer, equals(kPrussianBlue));
    expect(kColorScheme.surface, equals(kRichBlack));
    expect(kColorScheme.background, equals(kRichBlack));
    expect(kColorScheme.error, equals(Colors.red));
    expect(kColorScheme.onPrimary, equals(kRichBlack));
    expect(kColorScheme.onSecondary, equals(Colors.white));
    expect(kColorScheme.onSurface, equals(Colors.white));
    expect(kColorScheme.onBackground, equals(Colors.white));
    expect(kColorScheme.onError, equals(Colors.white));
    expect(kColorScheme.brightness, equals(Brightness.dark));
  });
}
