import 'package:app_cliente/Widgets/NavbarCliente.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // 1. Controller declarado no escopo da classe para manter o estado
  late final TextEditingController _searchController;
  bool _isEditing = false;
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

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const NavbarCliente(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER DA PÁGINA ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Meu Perfil',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1E293B)),
                  ),
                  Row(
                    children: [
                      // O botão de Editar some quando já estamos editando
                      if (!_isEditing) ...[
                        OutlinedButton.icon(
                          onPressed: _toggleEdit,
                          icon: const Icon(LucideIcons.pencil, size: 16),
                          label: const Text('Editar'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: colorScheme.primary,
                            side: BorderSide(color: colorScheme.primary.withOpacity(0.5)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      // Botão Sair
                      TextButton.icon(
                        onPressed: () {
                          // Ação de sair (Logout)
                        },
                        icon: const Icon(LucideIcons.logOut, size: 16),
                        label: const Text('Sair'),
                        style: TextButton.styleFrom(foregroundColor: Colors.red.shade600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- CONTAINER PRINCIPAL (Alterna entre Ver e Editar) ---
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: _isEditing ? _buildEditForm(theme, colorScheme, isDark) : _buildProfileView(theme, colorScheme, isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: colorScheme.primary, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(color: theme.brightness == Brightness.dark ? Colors.white : const Color(0xFF334155))),
      ],
    );
  }

  // ==========================================
  // MODO DE EDIÇÃO
  // ==========================================
  Widget _buildEditForm(ThemeData theme, ColorScheme colorScheme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Editar Perfil',
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1E293B)),
        ),
        const SizedBox(height: 24),
        Divider(color: colorScheme.outlineVariant, height: 1),
        const SizedBox(height: 24),

        _buildTextField('Nome', 'Maria Eduarda Santos', colorScheme),
        const SizedBox(height: 16),
        _buildTextField('Telefone', '(21) 97654-3210', colorScheme),
        const SizedBox(height: 16),
        _buildTextField('Bio', 'Eletricista com CREA ativo. Especialista em instalações industriais e automação.', colorScheme, maxLines: 3),

        const SizedBox(height: 24),
        Text('Endereço', style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 16),

        _buildTextField('Rua', 'Rua Voluntários da Pátria', colorScheme),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField('Número', '300', colorScheme)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Complemento', 'Apto 201', colorScheme)),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField('Bairro', 'Botafogo', colorScheme)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('Cidade', 'Rio de Janeiro', colorScheme)),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField('Estado', 'RJ', colorScheme)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField('CEP', '22270010', colorScheme)),
          ],
        ),

        const SizedBox(height: 32),
        Divider(color: colorScheme.outlineVariant, height: 1),
        const SizedBox(height: 24),

        // Botões de Ação do Formulário
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _toggleEdit, // Cancela e volta pra visualização
              style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
              child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                // Aqui iria a lógica de salvar os dados na API
                _toggleEdit(); // Finge que salvou e volta pra view
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              child: const Text('Salvar alterações', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileView(ThemeData theme, ColorScheme colorScheme, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho do Perfil
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: isDark ? Colors.grey.shade800 : Colors.grey.shade100, shape: BoxShape.circle),
              child: Icon(LucideIcons.user, size: 32, color: colorScheme.onSurfaceVariant),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Maria Eduarda Santos',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1E293B)),
                ),
                Text('maria.eletricista@gmail.com', style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildBadge('Free', colorScheme),
                    const SizedBox(width: 8),
                    _buildBadge('Verificado', colorScheme),
                    const SizedBox(width: 12),
                    Icon(LucideIcons.star, color: Colors.amber.shade500, size: 14),
                    const SizedBox(width: 4),
                    Text('4.5', style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),

        // Grid de Informações
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildInfoItem('Telefone', '(21) 97654-3210', theme, colorScheme)),
            Expanded(child: _buildInfoItem('Profissão', 'Eletricista Industrial (Electrician)', theme, colorScheme)),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildInfoItem('Tipo', 'Individual', theme, colorScheme)),
            Expanded(child: _buildInfoItem('Membro desde', '27/02/2026', theme, colorScheme)),
          ],
        ),
        const SizedBox(height: 24),
        _buildInfoItem('Bio', 'Eletricista com CREA ativo. Especialista em instalações industriais e automação.', theme, colorScheme),
        const SizedBox(height: 24),
        _buildInfoItem('Endereço', 'Rua Voluntários da Pátria, 300 — Rio de Janeiro, RJ', theme, colorScheme),
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue, ColorScheme colorScheme, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
      ],
    );
  }
}
