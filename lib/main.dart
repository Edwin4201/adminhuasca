import 'package:adminhuasca/routes/pageroutes.dart';
import 'package:adminhuasca/screens/comentarios_screen.dart';
import 'package:adminhuasca/screens/login_screen.dart';
import 'package:adminhuasca/screens/lugares_agregar_screen.dart';
import 'package:adminhuasca/screens/lugares_editar_screen.dart';
import 'package:adminhuasca/screens/lugares_screen.dart';
import 'package:adminhuasca/screens/top_lugares_screen.dart';
import 'package:adminhuasca/screens/visitas_detalles_screen.dart';
import 'package:adminhuasca/screens/visitas_lugar_screen.dart';
import 'package:adminhuasca/services/estados_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EstadosService()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            useMaterial3: true,
            dialogTheme: const DialogTheme(shadowColor: Colors.red),
            snackBarTheme: const SnackBarThemeData(
                backgroundColor: Colors.green,
                actionTextColor: Colors.white,
                disabledActionTextColor: Colors.white,
                contentTextStyle: TextStyle(fontSize: 18),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                showCloseIcon: true,
                closeIconColor: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
        routes: {
          PageRoutes.top: (context) => const TopLugaresScreen(),
          PageRoutes.comentarios: (context) => const ComentariosScreen(),
          PageRoutes.lugares: (context) => const LugaresScreen(),
          PageRoutes.visitasLugar: (context) => const VisitasLugarScreen(),
          "agregarlugar": (context) => LugaresAgregarScreen(),
          "editarlugar": (context) => LugaresEditarScreen(),
          "lugares": (context) => LugaresScreen(),
          "visitasdetalles": (context) => VisitasDetallesScreen(),
          "auth": (context) => ComentariosScreen()
        },
      ),
    );
  }
}
