import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_know_app/pages/home_page.dart';
import 'package:should_know_app/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'l10n/l10n.dart';

void main() async {
  await Future.delayed(const Duration(seconds: 2));
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Should Know",
      theme: Provider.of<ThemeProvider>(context).themeData,
      supportedLocales: L10n.all,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: Locale( Provider.of<ThemeProvider>(context).selectedLanguage),
      home: HomePage(),
    );
  }
}
