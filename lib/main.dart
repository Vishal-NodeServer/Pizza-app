import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'screens/splash/splash_screen.dart'; // Update with the correct path Update with the correct path
import '../screens/main/nav_pages/home/home_category/food/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Pizza&Hungry",
        home:
            SplashScreen(), // SplashScreen will handle navigation to LoginPage
      ),
    );
  }
}
