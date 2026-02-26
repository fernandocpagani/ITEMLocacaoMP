import 'package:flutter/material.dart';
import 'package:itemloca/Core/Services/ApiInterface.dart';
import 'package:itemloca/Core/Services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nucleusIdCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  late AuthServiceLogin authService;
  late ApiInterface apiService;

  bool _loading = false;
  bool _savePassword = false;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    apiService = context.read<ApiInterface>();
    authService = AuthServiceLogin(apiService: apiService);
    await apiService.carregarUrlBase();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savePassword = prefs.getBool('savePassword') ?? false;
      if (_savePassword) {
        _nucleusIdCtrl.text = prefs.getString('nucleusId') ?? '';
        _emailCtrl.text = prefs.getString('email') ?? '';
        _passwordCtrl.text = prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final response = await authService.loginCustumer(_emailCtrl.text, _nucleusIdCtrl.text, _passwordCtrl.text);
      print('response loginScreen ${response}');
      final prefs = await SharedPreferences.getInstance();
      if (_savePassword) {
        await prefs.setBool('savePassword', true);
        await prefs.setString('nucleusId', _nucleusIdCtrl.text);
        await prefs.setString('email', _emailCtrl.text);
        await prefs.setString('password', _passwordCtrl.text);
      } else {
        await prefs.clear();
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login realizado com sucesso')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Credenciais inválidas'), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícone
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.12), shape: BoxShape.circle),
                    child: const Icon(Icons.shopping_bag_outlined, color: Colors.green, size: 28),
                  ),

                  const SizedBox(height: 16),

                  Text('Login Cliente', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 6),

                  Text(
                    'Acesse como cliente de um núcleo específico',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  _input(controller: _nucleusIdCtrl, label: 'ID do Núcleo', hint: 'ID do núcleo'),

                  const SizedBox(height: 12),

                  _input(controller: _emailCtrl, label: 'E-mail', hint: 'email@exemplo.com', keyboard: TextInputType.emailAddress),

                  const SizedBox(height: 12),

                  _input(controller: _passwordCtrl, label: 'Senha', hint: 'Sua senha', obscure: true),

                  const SizedBox(height: 8),

                  SwitchListTile(value: _savePassword, onChanged: (v) => setState(() => _savePassword = v), contentPadding: EdgeInsets.zero, title: const Text('Salvar senha'), activeColor: Colors.green),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _loading ? null : _onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _loading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Entrar'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 18),
                    label: const Text('Voltar'),
                    style: TextButton.styleFrom(foregroundColor: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _input({required TextEditingController controller, required String label, required String hint, bool obscure = false, TextInputType keyboard = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboard,
          validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF2F6FC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nucleusIdCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }
}
