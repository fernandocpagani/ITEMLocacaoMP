import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CardMinhasAssociacoes extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;

  const CardMinhasAssociacoes({super.key, required this.title, required this.subtitle, this.status = 'Ativo'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          // Ícone
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: isDark ? Colors.grey.shade800 : Colors.grey.shade100, shape: BoxShape.circle),
            child: Icon(LucideIcons.building2, color: colorScheme.onSurfaceVariant, size: 20),
          ),
          const SizedBox(width: 16),

          // Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : const Color(0xFF1E293B)),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),

          // Badge "Ativo"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
            ),
            child: Text(
              status,
              style: TextStyle(color: colorScheme.primary, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
