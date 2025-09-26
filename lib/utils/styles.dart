// import 'package:flutter/material.dart';
// import 'package:gennii_app/utils/colors.dart';

// class Styles {
//   static ThemeData themeData(bool isDarkTheme) {
//     // light theme
//     final lightTheme = ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: white,
//         appBarTheme: AppBarTheme(
//             backgroundColor: white, iconTheme: IconThemeData(color: black)),
//         navigationBarTheme: NavigationBarThemeData(
//           backgroundColor: white,
//         ),
//         colorScheme: ColorScheme.light().copyWith(
//             secondary: black,
//             primary: kPrimaryColor,
//             primaryContainer: widgetBg,
//             tertiary: baseLightShimmerColor, // shimmer base color
//             tertiaryContainer:
//                 highlightLightShimmerColor, // shimmer highlighter
//             brightness: Brightness.light));

//     // dark theme

//     final darkTheme = ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: black,
//         appBarTheme: AppBarTheme(
//             backgroundColor: black, iconTheme: IconThemeData(color: white)),
//         navigationBarTheme: NavigationBarThemeData(backgroundColor: black),
//         colorScheme: ColorScheme.light().copyWith(
//             secondary: white,
//             primary: kPrimaryColor,
//             primaryContainer: darkWidgetBg,
//             tertiary: baseDarkShimmerColor, // shimmer base color
//             tertiaryContainer: highlightDarkShimmerColor, // shimmer highlighter
//             brightness: Brightness.dark));

//     if (isDarkTheme == false) {
//       return lightTheme;
//     } else {
//       return darkTheme;
//     }
//   }
// }
