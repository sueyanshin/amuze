import 'package:amuze_app/app_button.dart';
import 'package:amuze_app/main.dart';
import 'package:amuze_app/screens/providers/auth_provider.dart';
import 'package:amuze_app/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await context.read<AuthProvider>().login(
      emailOrPhone: _emailController.text,
      password: _passwordController.text,
    );

    if (!mounted) return;
    if (!success) {
      final message = context.read<AuthProvider>().errorMessage;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Amuze',
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  'auth.welcome_back'.tr(),
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontSize: 30,
                    fontWeight: .w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  'auth.login_subtext'.tr(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      AppTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "auth.validation.enter_registered_email_or_phone"
                                .tr();
                          }
                          return null;
                        },
                        controller: _emailController,
                        labelText: 'auth.email_or_phone_label'.tr(),
                        hintText: 'auth.email_or_phone_hint'.tr(),
                        isPassword: false,
                        textInputAction: .next,
                        keyboardType: .emailAddress,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "auth.validation.enter_password".tr();
                          } else if (value.length < 6) {
                            return "auth.validation.password_min_length".tr();
                          }
                          return null;
                        },
                        controller: _passwordController,
                        labelText: 'auth.password_label'.tr(),
                        hintText: 'auth.password_hint'.tr(),
                        isPassword: !_isPasswordVisible,
                        keyboardType: .visiblePassword,
                        textInputAction: .next,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: _isPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                          return AppButton(
                            backgroundColor: provider.isLoading
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.8,
                                  )
                                : theme.colorScheme.primary,
                            child: provider.isLoading
                                ? Text(
                                    'common.loading'.tr(),
                                    style: theme.textTheme.labelMedium!
                                        .copyWith(
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                  )
                                : Text(
                                    'auth.login_button'.tr(),
                                    style: theme.textTheme.labelMedium!
                                        .copyWith(
                                          color: theme.colorScheme.onPrimary,
                                        ),
                                  ),
                            onPressed: () {
                              provider.isLoading ? null : login();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        alignment: .center,
                        children: [
                          Text('auth.new_to_multiverse'.tr()),
                          Text(
                            'auth.create_account'.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
