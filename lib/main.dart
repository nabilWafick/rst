import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/home/views/page/home.page.dart';
import 'package:rst/routes/routes.dart';
import 'package:rst/utils/theme/theme_data.util.dart';

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
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}
