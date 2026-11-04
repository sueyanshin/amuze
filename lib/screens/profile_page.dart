import 'package:amuze_app/screens/settings_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              // Profile info
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: theme.colorScheme.primary,
                      child:
                          // Text(
                          //   'Jimmy',
                          //   style: theme.textTheme.titleMedium?.copyWith(
                          //     color: theme.colorScheme.onPrimaryContainer,
                          //     fontWeight: .bold,
                          //   ),
                          // ),
                          CachedNetworkImage(
                            fit: .cover,
                            imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg2eDnnC171CPUNWXfOHsBrFRTLLtL8akN5mqsCcn6DQ&s",
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Harry',
                      style: theme.textTheme.titleLarge!.copyWith(
                        fontWeight: .bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'harry@gmail.com',
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Settings
              Text(
                'settings.account_and_preferences'.tr(),
                style: theme.textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: .w400,
                ),
              ),

              ListTile(
                iconColor: theme.colorScheme.onSurfaceVariant,
                leading: Icon(Icons.settings_outlined),
                title: Text('settings.settings'.tr()),
                trailing: Icon(Icons.arrow_forward_ios, size: 20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
