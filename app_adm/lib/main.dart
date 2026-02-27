import 'package:app_adm/router/router.dart';
import 'package:core/Services/ApiInterface.dart';
import 'package:core/Services/ApiService.dart';
import 'package:core/Services/Providers/UrlProvider.dart';
import 'package:core/Services/Providers/UsuarioProvider.dart';
import 'package:core/Theme/AppThemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print(' API_BASE_URL: ${dotenv.env['API_BASE_URL']}');
  runApp(
    MultiProvider(
      providers: [
        Provider<ApiInterface>(create: (_) => ApiService()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => UrlProvider()..carregarUrl()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      theme: AppThemes.lightTheme,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
