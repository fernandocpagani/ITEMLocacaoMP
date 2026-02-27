import 'package:app_cliente/Widgets/NavbarCliente.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MinhasLocacoesScreen extends StatefulWidget {
  const MinhasLocacoesScreen({super.key});

  @override
  State<MinhasLocacoesScreen> createState() => _MinhasLocacoesScreenState();
}

class _MinhasLocacoesScreenState extends State<MinhasLocacoesScreen> {
  // 1. CORREÇÃO DE LÓGICA: As variáveis de estado ficam aqui, FORA do build!
  bool _isDropdownOpen = true;
  String _selectedFilter = 'Todos';

  final List<String> _filters = ['Todos', 'Pendente', 'Aguardando Retirada', 'Em Andamento', 'Devolvido', 'Cancelado'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const NavbarCliente(),
      // 2. CORREÇÃO DE LAYOUT: O SingleChildScrollView foi removido.
      // O Scaffold vai dar um limite de altura para a tela, e o Expanded vai funcionar.
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Meus Aluguéis',
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1E293B)),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Ação de explorar
                  },
                  icon: const Icon(LucideIcons.compass, size: 16),
                  label: const Text('Explorar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                    side: BorderSide(color: colorScheme.primary.withOpacity(0.5)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- CORPO DA TELA ---
            // 3. Agora este Expanded sabe exatamente qual o espaço limite que ele tem para crescer.
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lado Esquerdo: Filtro (Dropdown Customizado)
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Botão do Dropdown
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isDropdownOpen = !_isDropdownOpen;
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              border: Border.all(color: colorScheme.outlineVariant),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedFilter, style: TextStyle(color: isDark ? Colors.white : const Color(0xFF334155))),
                                Icon(LucideIcons.chevronDown, size: 16, color: colorScheme.onSurfaceVariant),
                              ],
                            ),
                          ),
                        ),

                        // Menu do Dropdown (Aberto)
                        if (_isDropdownOpen) ...[
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: theme.cardColor,
                              border: Border.all(color: colorScheme.outlineVariant),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                            ),
                            child: Column(
                              children: [
                                // Campo de Busca interno
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: 36,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(color: colorScheme.outlineVariant),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(color: colorScheme.outlineVariant),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(color: colorScheme.primary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(height: 1),

                                // Lista de Opções
                                ..._filters.map((filter) {
                                  final isSelected = filter == _selectedFilter;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedFilter = filter;
                                        _isDropdownOpen = false;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                      color: isSelected && !isDark ? Colors.grey.shade50 : Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(filter, style: TextStyle(color: isDark ? Colors.white : const Color(0xFF334155), fontSize: 14)),
                                          if (isSelected) Icon(LucideIcons.check, size: 16, color: isDark ? Colors.white : const Color(0xFF1E293B)),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Centro: Empty State (Estado Vazio)
                  // Este Expanded ocupa o restante da tela à direita do menu!
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.package, size: 48, color: colorScheme.onSurfaceVariant.withOpacity(0.8)),
                          const SizedBox(height: 16),
                          Text('Você ainda não possui aluguéis.', style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant)),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              // Ação para navegar aos catálogos
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Explorar catálogos', style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
