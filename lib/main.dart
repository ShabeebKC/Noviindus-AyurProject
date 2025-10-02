import 'package:ayur_project/utils/shared_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'modules/home/screens/splash_screen.dart';
import 'modules/home/view_model/home_view_model.dart';
import 'modules/login/view_models/login_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'Ayur-Noviindus',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
