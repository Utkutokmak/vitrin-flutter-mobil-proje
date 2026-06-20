import 'package:flutter/material.dart';
import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/splash_screen.dart';
import 'state/cart_model.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const VitrinApp());
}

class VitrinApp extends StatefulWidget {
  const VitrinApp({super.key});

  @override
  State<VitrinApp> createState() => _VitrinAppState();
}

class _VitrinAppState extends State<VitrinApp> {
  final CartModel _cart = CartModel();
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cart: _cart,
      child: MaterialApp(
        title: 'Vitrin',
        debugShowCheckedModeBanner: false,
        themeMode: _themeMode,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const SplashScreen(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                builder: (_) => HomeScreen(onToggleTheme: toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
              );
            case '/product-detail':
              final product = settings.arguments as Product;
              return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product));
            case '/cart':
              return MaterialPageRoute(builder: (_) => const CartScreen());
            default:
              return MaterialPageRoute(
                builder: (_) => HomeScreen(onToggleTheme: toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
              );
          }
        },
      ),
    );
  }
}
