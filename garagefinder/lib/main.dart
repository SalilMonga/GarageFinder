import 'package:flutter/material.dart';
import 'package:garagefinder/screens/home_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.cupertino(
      cupertinoThemeBuilder: (context, theme) {
        return theme.copyWith(applyThemeToAll: true);
      },
      materialThemeBuilder: (context, theme) {
        return theme.copyWith(
          appBarTheme: const AppBarTheme(toolbarHeight: 52),
        );
      },
      home: LoginScreen(),
    );
  }
}

