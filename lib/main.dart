import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/presentation/style/themeclass.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lyekwtnueeecuoepabog.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5ZWt3dG51ZWVlY3VvZXBhYm9nIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDczNzA2MDcsImV4cCI6MjAyMjk0NjYwN30.2iDz0zGXvVBKpMj1BD2arOCjsKXhPLVyK0pOodfNf1M',
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? val = sharedPreferences.getBool('themeValue');
    if (val == null) {
      sharedPreferences.setBool('themeValue', false);
      getTheme();
    }
    if (val != null) {
      setState(() {
        _themeMode = val ? _themeMode = ThemeMode.dark : ThemeMode.light;
      });
    }
  }

  void changeTheme(ThemeMode themeMode) async {
    setState(() {
      _themeMode = themeMode;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(
        'themeValue', _themeMode == ThemeMode.dark ? true : false);
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {
    Navigate navigate = Navigate();
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: navigate.initialRoute,
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          themeMode: _themeMode,
          routes: navigate.route,
        ));
  }
}
