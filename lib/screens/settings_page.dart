import 'package:amuze_app/core/app_theme.dart';
import 'package:amuze_app/screens/login_page.dart';
import 'package:amuze_app/screens/providers/auth_provider.dart';
import 'package:amuze_app/screens/providers/settings_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const new({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
    {'code': 'my', 'name': 'မြန်မာ', 'flag': '🇲🇲'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('settings.settings'.tr())),

      body: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          final isDark = provider.themeMode.isDark;
          print(provider.locale.languageCode);
          return SingleChildScrollView(
            padding: .symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'settings.preferences'.tr(),
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: .w400,
                    ),
                  ),
                ),

                Card(
                  child: SwitchListTile(
                    value: isDark ? true : false,
                    onChanged: (value) {
                      provider.updateThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                    secondary: isDark
                        ? Icon(
                            Icons.dark_mode,
                            color: theme.colorScheme.primary,
                          )
                        : Icon(Icons.light_mode, color: AppColors.comicAmber),
                    title: Text(
                      isDark
                          ? 'settings.dark_mode'.tr()
                          : "settings.light_mode".tr(),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text('settings.languages'.tr()),
                    trailing: DropdownMenu<String>(
                      textAlign: .end,
                      showTrailingIcon: false,
                      initialSelection: context.locale.languageCode,

                      onSelected: (String? code) async {
                        if (code != null) {
                          final newLocale = Locale(code);
                          await context.setLocale(newLocale);
                          await provider.updateLocale(newLocale);
                        }
                      },
                      inputDecorationTheme: InputDecorationTheme(
                        border: .none,
                        isDense: true,
                        contentPadding: .zero,
                      ),
                      dropdownMenuEntries: languages.map((lang) {
                        return DropdownMenuEntry<String>(
                          value: lang['code']!,
                          label: lang['name']!,
                          leadingIcon: Text(
                            lang['flag']!,
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.error,
                            foregroundColor: theme.colorScheme.onPrimary,
                          ),
                          onPressed: () {
                            authProvider.logout();
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false,
                              );
                            }
                          },

                          icon: Icon(Icons.logout),
                          label: Text('auth.logout_button'.tr()),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
