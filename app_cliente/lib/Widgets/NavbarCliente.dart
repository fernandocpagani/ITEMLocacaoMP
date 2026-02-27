import 'package:core/Theme/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

class NavbarCliente extends StatefulWidget implements PreferredSizeWidget {
  const NavbarCliente({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);

  @override
  State<NavbarCliente> createState() => _NavbarClienteState();
}

class NavItem {
  final String label;
  final String route;
  final IconData icon;

  NavItem({required this.label, required this.route, required this.icon});
}

class _NavbarClienteState extends State<NavbarCliente> {
  final List<NavItem> links = [
    NavItem(label: 'Explorar', route: '/marketplace', icon: LucideIcons.compass),
    NavItem(label: 'Ferramentas', route: '/marketplace/explore', icon: LucideIcons.wrench),
    NavItem(label: 'Locadores', route: '/marketplace/nucleos', icon: LucideIcons.building2),
    NavItem(label: 'Minhas Locações', route: '/marketplace/minhaslocacoes', icon: LucideIcons.clipboardList),
    NavItem(label: 'Memberships', route: '/marketplace/memberships', icon: LucideIcons.personStanding200), // Atualizei o ícone para ficar diferente
  ];
  String? userName;
  int unreadNotifications = 0;

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    bool isAuthenticated = true;
    final String currentRoute = GoRouterState.of(context).uri.toString();

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: themeController.isDark ? Colors.grey.shade900 : Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Divider(height: 1.0, thickness: 1.0, color: colorScheme.outlineVariant),
      ),
      // Removi o 'widget.tituloPagina' pois ele estava empurrando os itens para o meio.
      // O design original não tem título no meio da navbar, só o "Marketplace" na esquerda.
      actions: [
        // Lado Esquerdo (Logo)
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: InkWell(
            onTap: () => context.go('/marketplace'),
            child: Row(
              children: [
                Icon(LucideIcons.hexagon, size: 24, color: colorScheme.primary), // Corrigi o ícone verde
                const SizedBox(width: 8),
                Text(
                  'Marketplace',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: isDark ? Colors.white : const Color(0xFF334155)),
                ),
              ],
            ),
          ),
        ),

        // Centro (Links de Navegação)
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: links.map((link) {
                // 2. VERIFICANDO SE O BOTÃO ESTÁ ATIVO
                // Compara se a rota do botão é igual à rota em que o app está agora
                final isActive = currentRoute == link.route;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextButton.icon(
                    onPressed: () => context.go(link.route),
                    icon: Icon(link.icon, size: 18),
                    label: Text(link.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                    style: TextButton.styleFrom(
                      // 3. APLICANDO AS CORES CONDICIONAIS
                      // Se ativo = Verde Primário. Se inativo = Cinza do tema.
                      foregroundColor: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
                      // Se ativo = Fundo verde transparente (0.1 = 10% de opacidade). Se inativo = Transparente.
                      backgroundColor: isActive ? colorScheme.primary.withOpacity(0.1) : Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        // Lado Direito (Ações e Perfil)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(themeController.isDark ? LucideIcons.moon : LucideIcons.sun, size: 20),
                onPressed: () {
                  themeController.toggleTheme();
                },
                color: Colors.grey.shade600,
              ),

              if (isAuthenticated) ...[
                Badge(
                  isLabelVisible: unreadNotifications > 0,
                  label: Text(unreadNotifications > 9 ? '9+' : unreadNotifications.toString()),
                  backgroundColor: Colors.red,
                  offset: const Offset(-4, 4),
                  child: IconButton(icon: const Icon(LucideIcons.bell, size: 20), color: Colors.grey.shade600, onPressed: () {}),
                ),
                const SizedBox(width: 8),

                ActionChip(
                  avatar: Icon(LucideIcons.user, size: 16, color: colorScheme.primary),
                  label: Text(
                    userName ?? 'Perfil',
                    style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.primary),
                  ),
                  backgroundColor: colorScheme.primary.withOpacity(0.1), // Fundo verde clarinho no chip do usuário
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  onPressed: () => context.go('/marketplace/perfil'),
                ),

                IconButton(icon: const Icon(LucideIcons.logOut, size: 20), color: Colors.grey.shade600, onPressed: () {}),
              ] else ...[
                ElevatedButton(onPressed: () => context.go('/auth/member/login'), style: ElevatedButton.styleFrom(elevation: 0), child: const Text('Entrar')),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
