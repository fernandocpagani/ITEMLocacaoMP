import 'package:app_cliente/Widgets/NavbarCliente.dart';
import 'package:app_cliente/Widgets/NucleusCardModel.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LocadoresScreen extends StatefulWidget {
  const LocadoresScreen({super.key});

  @override
  State<LocadoresScreen> createState() => _LocadoresScreenState();
}

class _LocadoresScreenState extends State<LocadoresScreen> {
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
              Text('Diretórios de locadores', textAlign: TextAlign.center, style: theme.textTheme.titleLarge?.copyWith(fontSize: 32)),

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
                            hintText: 'Buscar ...',
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
              NucleusCard(
                nucleus: NucleusCardModel(id: '123', name: 'Associação TechTools RJ', type: 'Association', rating: 4.2, description: 'Associação de profissionais técnicos do Rio de Janeiro. Foco em equipamentos de construção civil.', city: 'Rio de Janeiro', state: 'RJ'),
                onCatalogPressed: () {
                  print('Navegando para o catálogo do núcleo...');
                  // Aqui você usaria o GoRouter: context.go('/marketplace/nucleos/123');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
