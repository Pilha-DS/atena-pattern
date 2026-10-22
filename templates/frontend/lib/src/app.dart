import 'package:atena_ui/atena_ui.dart';
import 'package:flutter/material.dart';

import 'core/config/app_config.dart';
import 'features/home/presentation/home_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ToatController _toat = ToatController();

  @override
  void dispose() {
    _toat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      builder: (context, child) => ToatHost(
        controller: _toat,
        child: child ?? const SizedBox.shrink(),
      ),
      home: HomePage(toat: _toat),
    );
  }
}
