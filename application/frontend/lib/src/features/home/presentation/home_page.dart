import 'package:atena_ui/atena_ui.dart';
import 'package:flutter/material.dart';

import '../../../core/config/app_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.toat});

  final ToatController toat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppLogo(size: 72),
                  const SizedBox(height: AppSpacing.md),
                  Text(AppConfig.appName, style: theme.textTheme.headlineMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Base pronta: tema, TOAT e cliente do envelope.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: 'Testar notificação',
                    icon: Icons.notifications_outlined,
                    onPressed: () => toat.show(
                      'Tudo certo por aqui.',
                      variant: ToatVariant.success,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
