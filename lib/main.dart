import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/auth/connection/views/page/connection.page.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/home/views/page/home.page.dart';
import 'package:rst/routes/routes.dart';
import 'package:rst/utils/constants/preferences_keys/preferences_keys.constant.dart';
import 'package:rst/utils/theme/theme_data.util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // disconnect on init
  await AuthFunctions.disconnectOnInit();

  // run the app
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
      home: // const MainPage(),
          //   const WidgetTest()
          const MainPage(),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStoredData();
    });
    super.initState();
  }

  _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    final authName = prefs.getString(RSTPreferencesKeys.name);
    final authFirstnames = prefs.getString(RSTPreferencesKeys.firstnames);
    final authPermissions = prefs.getString(RSTPreferencesKeys.permissions);
    final authAccesToken = prefs.getString(RSTPreferencesKeys.accesToken);
    final authEmail = prefs.getString(RSTPreferencesKeys.email);

    ref.read(authNameProvider.notifier).state = authName;
    ref.read(authFirstnamesProvider.notifier).state = authFirstnames;
    ref.read(authAccesTokenProvider.notifier).state = authAccesToken;
    ref.read(authEmailProvider.notifier).state = authEmail;

    if (authPermissions != null) {
      try {
        final Map<String, dynamic> permissions = jsonDecode(authPermissions);
        ref.read(authPermissionsProvider.notifier).state = permissions;
      } catch (e) {
        debugPrint('Error parsing permissions: $e');
        ref.read(authPermissionsProvider.notifier).state = null;
      }
    } else {
      ref.read(authPermissionsProvider.notifier).state = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authEmail = ref.watch(authEmailProvider);

    return Scaffold(
      body: authEmail != null ? const HomePage() : const ConnectionPage(),
    );
  }
}
