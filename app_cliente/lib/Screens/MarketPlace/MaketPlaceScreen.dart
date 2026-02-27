import 'package:app_cliente/Widgets/NavbarCliente.dart';
import 'package:app_cliente/Widgets/NucleusCardModel.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MarketPlaceScreen extends StatefulWidget {
  const MarketPlaceScreen({super.key});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  // 1. Controller declarado no escopo da classe para manter o estado
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                              controller: _searchController,
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
                    const SizedBox(height: 16),

                    // Botão de "Buscar próximos de mim"
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.send, size: 16),
                      label: const Text('Buscar próximos de mim'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.onSurface,
                        side: BorderSide(color: colorScheme.outline),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
            ],
          ),
        ),
      ),
    );
  }
}
