import 'package:app_cliente/Widgets/NavbarCliente.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ItensScreen extends StatefulWidget {
  const ItensScreen({super.key});

  @override
  State<ItensScreen> createState() => _ItensScreenState();
}

class _ItensScreenState extends State<ItensScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: const NavbarCliente(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Marketplace de Ferramentas', textAlign: TextAlign.center, style: theme.textTheme.titleLarge?.copyWith(fontSize: 32)),
              const SizedBox(height: 12),
              Text(
                'Encontre cooperativas e alugue equipamentos próximos a você.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 40),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: TextField(
                          controller: null,
                          decoration: InputDecoration(
                            hintText: 'Buscar núcleos...',
                            hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                            prefixIcon: Icon(LucideIcons.search, color: colorScheme.onSurfaceVariant, size: 20),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: colorScheme.outlineVariant),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: colorScheme.primary, width: 2),
                            ),
                            filled: true,
                            fillColor: theme.cardColor,
                          ),
                          onSubmitted: (value) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          // O shape (borda) já está sendo aplicado globalmente pelo seu AppThemes!
                        ),
                        child: const Text('Buscar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
