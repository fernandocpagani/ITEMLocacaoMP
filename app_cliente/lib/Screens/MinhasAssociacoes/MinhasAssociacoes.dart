import 'package:app_cliente/Widgets/CardExplorarNucleos.dart';
import 'package:app_cliente/Widgets/CardMinhasAssociacoes.dart';
import 'package:app_cliente/Widgets/NavbarCliente.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MinhasAssociacoes extends StatefulWidget {
  const MinhasAssociacoes({super.key});

  @override
  State<MinhasAssociacoes> createState() => _MinhasAssociacoesState();
}

class _MinhasAssociacoesState extends State<MinhasAssociacoes> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Estilo padrão para os títulos das seções
    final sectionTitleStyle = theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1E293B));

    return Scaffold(
      appBar: const NavbarCliente(),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- SEÇÃO 1: Minhas Associações ---
                Text('Minhas Associações', style: sectionTitleStyle),
                const SizedBox(height: 16),

                // Card Estático
                const CardMinhasAssociacoes(title: 'Cooperativa Ferramentas SP', subtitle: 'Member · Pro · Desde 09/02/2026', status: 'Ativo'),

                const SizedBox(height: 32),
                Divider(color: colorScheme.outlineVariant),
                const SizedBox(height: 32),

                // --- SEÇÃO 2: Explorar Núcleos ---
                Text('Explorar Núcleos', style: sectionTitleStyle),
                const SizedBox(height: 16),

                // Barra de Busca
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Buscar núcleo...',
                            hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
                            prefixIcon: Icon(LucideIcons.search, color: colorScheme.onSurfaceVariant, size: 18),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: colorScheme.outlineVariant),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: colorScheme.primary),
                            ),
                            filled: true,
                            fillColor: theme.cardColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // Ação de busca
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Text('Buscar', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Lista de Cards (Usando Wrap para responsividade)
                Wrap(
                  spacing: 16, // Espaço horizontal entre os cards
                  runSpacing: 16, // Espaço vertical se quebrar a linha
                  children: [
                    CardExplorarNucleos(
                      title: 'Cooperativa Ferramentas SP',
                      type: 'Cooperative',
                      isMember: true, // Renderiza o botão "Já é membro"
                      onActionPressed: () {},
                    ),
                    CardExplorarNucleos(
                      title: 'Associação TechTools RJ',
                      type: 'Association',
                      isMember: false, // Renderiza o botão "Solicitar associação"
                      onActionPressed: () {
                        print("Solicitando...");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
