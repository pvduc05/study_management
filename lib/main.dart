import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/study_database.dart';
import 'struct/appState.dart';
import 'struct/databaseGlobal.dart';
import 'struct/documentFunctions.dart';
import 'widgets/navigationFramework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final databaseGlobal = DatabaseGlobal();
  final database = await databaseGlobal.initialize();
  final appState = AppState(preferences)..initialize();
  runApp(
    StudyDocsApp(
      databaseGlobal: databaseGlobal,
      database: database,
      appState: appState,
    ),
  );
}

class StudyDocsApp extends StatelessWidget {
  const StudyDocsApp({
    required this.databaseGlobal,
    required this.database,
    required this.appState,
    super.key,
  });

  final DatabaseGlobal databaseGlobal;
  final StudyDatabase database;
  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
        Provider<StudyDatabase>.value(value: database),
        Provider<DocumentFunctions>(create: (_) => DocumentFunctions(database)),
      ],
      child: Consumer<AppState>(
        builder: (context, state, _) => MaterialApp(
          title: 'StudyDocs',
          debugShowCheckedModeBanner: false,
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF315EFB),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF8EA5FF),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: const NavigationFramework(),
        ),
      ),
    );
  }
}
