import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CardExplorarNucleos extends StatelessWidget {
  final String title;
  final String type;
  final bool isMember;
  final VoidCallback? onActionPressed;

  const CardExplorarNucleos({super.key, required this.title, required this.type, required this.isMember, this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 320, // Largura fixa para manter o visual de grid/wrap da imagem
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Ícone
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: isDark ? Colors.grey.shade800 : Colors.grey.shade100, shape: BoxShape.circle),
                child: Icon(LucideIcons.building2, color: colorScheme.onSurfaceVariant, size: 18),
              ),
              const SizedBox(width: 12),

              // Textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: isDark ? Colors.white : const Color(0xFF1E293B), fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(type, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Botão Inferior Dinâmico (Membro vs Não Membro)
          SizedBox(
            width: double.infinity,
            height: 36,
            child: isMember
                // Estilo "Já é membro" (Fundo verde claro, sem borda, não clicável)
                ? Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: colorScheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      'Já é membro',
                      style: TextStyle(color: colorScheme.primary, fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                  )
                // Estilo "Solicitar associação" (Borda verde, texto verde, clicável)
                : OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(color: colorScheme.primary.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Solicitar associação', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
                  ),
          ),
        ],
      ),
    );
  }
}
