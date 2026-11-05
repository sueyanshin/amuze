import 'package:amuze_app/core/app_theme.dart';
import 'package:amuze_app/repository/auth_repository.dart';
import 'package:amuze_app/repository/post_repository.dart';
import 'package:amuze_app/repository/settings_repository.dart';
import 'package:amuze_app/screens/home_page.dart';
import 'package:amuze_app/screens/login_page.dart';
import 'package:amuze_app/screens/profile_page.dart';
import 'package:amuze_app/screens/providers/auth_provider.dart';
import 'package:amuze_app/screens/providers/nav_provider.dart';
import 'package:amuze_app/screens/providers/posts_provider.dart';
import 'package:amuze_app/screens/providers/settings_provider.dart';
import 'package:amuze_app/service/api_service.dart';
import 'package:amuze_app/service/settings_service.dart';
import 'package:amuze_app/service/token_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final apiService = ApiService();
  final tokenStorage = TokenStorage();
  final authRepository = AuthRepository(apiService, tokenStorage);
  final authProvider = AuthProvider(authRepository);
  await authProvider.restoreSession();
  final postRepository = PostRepository(apiService, tokenStorage);
  final settingsService = SettingsService();
  final settingsRepository = SettingsRepository(settingsService);

  final savedLocale = await settingsRepository.loadLocale();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en'), Locale('my')],
      fallbackLocale: const Locale('en'),
      startLocale: savedLocale,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
          ChangeNotifierProvider(create: (_) => PostProvider(postRepository)),
          // ChangeNotifierProvider(create: (_) => NavProvider()),
          ChangeNotifierProxyProvider<AuthProvider, NavProvider>(
            create: (_) => NavProvider(),
            update: (context, authProvider, navProvider) {
              if (authProvider.isAuthenticated == false) {
                navProvider!.resetIndex();
              }
              return navProvider!;
            },
          ),
          ChangeNotifierProvider(
            create: (_) => SettingsProvider(settingsRepository),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsProvider.themeMode,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return auth.isAuthenticated ? MainPage() : LoginPage();
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  new({super.key});

  final List<Widget> _screens = [HomePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<NavProvider>(
        builder: (context, provider, child) => _screens[provider.currentIndex],
      ),

      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<NavProvider>(
      builder: (context, provider, child) {
        final currentIndex = provider.currentIndex;
        return Container(
          height: 80,
          padding: .all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: .circular(20),
          ),
          child: Row(
            mainAxisAlignment: .spaceAround,
            children: [
              BottomNavItem(
                index: 0,
                icon: Icons.home_outlined,
                selectedIcon: Icons.home_filled,
                label: 'nav.home'.tr(),
                isSelected: currentIndex == 0 ? true : false,
              ),
              BottomNavItem(
                index: 1,
                icon: Icons.person_outline_rounded,
                selectedIcon: Icons.person,
                label: 'nav.profile'.tr(),
                isSelected: currentIndex == 1 ? true : false,
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomNavItem extends StatelessWidget {
  const new({
    super.key,
    required this.index,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
  });

  final int index;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navProvider = context.read<NavProvider>();
    return InkWell(
      onTap: () {
        navProvider.updateIndex(index);
      },
      child: AnimatedContainer(
        margin: .symmetric(vertical: 8),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 80,
        decoration: BoxDecoration(borderRadius: .circular(50)),
        child: Column(
          spacing: 4,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            Text(
              label,
              style: theme.textTheme.labelMedium!.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: .w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
