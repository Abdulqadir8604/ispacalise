import 'package:flutter/material.dart';

class mAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Function()? onBack;
  final Function()? onReset;

  const mAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.onBack,
    this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                title ?? '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                ),
              ),
              const SizedBox(height: 4),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
                  ),
                ),
            ],
          ),
          leading: onBack != null
              ? Padding(
            padding: const EdgeInsets.only(left: 16), // Add space before the back button
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.all(8),
                onPressed: onBack,
              ),
            ),
          )
              : null,
          actions: onReset != null
              ? [
            Padding(
              padding: const EdgeInsets.only(right: 16), // Add space before the reset button
              child: TextButton(
                onPressed: onReset,
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  ),
                ),
              ),
            ),
          ]
              : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
