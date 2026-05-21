import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x120F172A),
              blurRadius: 22,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Material(
          color: const Color(0xFFFFFCF6),
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.primaryContainer,
                          colorScheme.tertiaryContainer.withValues(alpha: 0.78),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(icon, color: colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -0.1,
                                  ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF667085),
                                    height: 1.35,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null)
                    IconTheme(
                      data: IconThemeData(color: colorScheme.primary),
                      child: trailing!,
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
