import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:should_know_app/theme/theme.dart';
import 'package:should_know_app/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String dropDownVal = "ar";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settingsLabel,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dark Mode Label
                  Text(
                    Provider.of<ThemeProvider>(context).themeData == lightMode
                        ? AppLocalizations.of(context)!.darkMode
                        : AppLocalizations.of(context)!.lightMode,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Provider.of<ThemeProvider>(context).themeData ==
                            lightMode
                        ? Icon(Icons.dark_mode)
                        : Icon(Icons.light_mode),
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(18),
              ),
              // Language Set
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.languageLabel,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton<String>(
                    items: [
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          "العربية",
                          style: TextStyle(fontFamily: 'Cairo'),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'en',
                        child: Text("English"),
                      ),
                    ],
                    value: Provider.of<ThemeProvider>(context).selectedLanguage,
                    icon: Icon(Icons.language),
                    underline: Container(
                      height: 1,
                      color: Color(0xFFF94871),
                    ),
                    onChanged: (value) {
                       Provider.of<ThemeProvider>(context, listen: false)
                          .setLanguage(value!);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on AppLocalizations {
  String get languageLabel => "languageLabel";
}
