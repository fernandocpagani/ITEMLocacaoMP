import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

// 1. Modelo de dados esperado pelo Card
class NucleusCardModel {
  final String id;
  final String name;
  final String type;
  final double rating;
  final String? description;
  final String city;
  final String state;
  final String? logoUrl;

  NucleusCardModel({required this.id, required this.name, required this.type, required this.rating, this.description, required this.city, required this.state, this.logoUrl});
}

// 2. O Componente Visual
class NucleusCard extends StatelessWidget {
  final NucleusCardModel nucleus;
  final VoidCallback onCatalogPressed;

  const NucleusCard({super.key, required this.nucleus, required this.onCatalogPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Row(
              children: [
                // Avatar / Logo
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest, shape: BoxShape.circle),
                  child: nucleus.logoUrl != null ? ClipOval(child: Image.network(nucleus.logoUrl!, fit: BoxFit.cover)) : Icon(LucideIcons.building2, color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(width: 12),

                // Textos do Header (Título, Badge e Rating)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nucleus.name,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          // Badge (Verde claro com texto verde forte)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
                            ),
                            child: Text(
                              nucleus.type,
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: colorScheme.primary),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Rating (Estrela)
                          Icon(LucideIcons.star, color: Colors.amber.shade500, size: 14),
                          const SizedBox(width: 4),
                          Text(nucleus.rating.toStringAsFixed(1), style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- BODY (Descrição) ---
            Text(
              nucleus.description ?? 'Sem descrição.',
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Equivalente ao line-clamp-2 do Tailwind
            ),

            const SizedBox(height: 12),

            // --- LOCATION ---
            Row(
              children: [
                Icon(LucideIcons.mapPin, size: 16, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${nucleus.city}, ${nucleus.state}',
                    style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // --- FOOTER (Botão) ---
            SizedBox(
              width: double.infinity,
              height: 40,
              child: OutlinedButton(
                onPressed: onCatalogPressed,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.primary, // Texto verde (primary)
                  side: BorderSide(color: colorScheme.primary), // Borda verde (primary)
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Ver Catálogo', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
