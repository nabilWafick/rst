import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/auth/connection/views/page/connection.page.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/home/views/page/home.page.dart';
import 'package:rst/routes/routes.dart';
import 'package:rst/utils/constants/preferences_keys/preferences_keys.constant.dart';
import 'package:rst/utils/theme/theme_data.util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(
    const ProviderScope(
      child: RSTApp(),
    ),
  );
}

class RSTApp extends ConsumerWidget {
  const RSTApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      title: 'RST App',
      theme: RSTThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesManager.main,
      onGenerateRoute: RoutesManager.onGenerateRoute,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulHookConsumerWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    _loadAuthData();
    super.initState();
  }

  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authEmail = prefs.getString(RSTPreferencesKeys.email);
    final authName = prefs.getString(RSTPreferencesKeys.name);
    final authFirstnames = prefs.getString(RSTPreferencesKeys.firstnames);
    final authAccesToken = prefs.getString(RSTPreferencesKeys.accesToken);

    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () {
      ref.read(authEmailProvider.notifier).state = authEmail ?? '';
      ref.read(authNameProvider.notifier).state = authName ?? '';
      ref.read(authFirstnamesProvider.notifier).state = authFirstnames ?? '';
      ref.read(authAccesTokenProvider.notifier).state = authAccesToken ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final authEmail = ref.watch(authEmailProvider);

    return Scaffold(
      body: authEmail != null ? const HomePage() : const ConnectionPage(),
    );
  }
}
