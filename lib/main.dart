import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'providers/cart_provider.dart';
import 'providers/food_provider.dart';
import 'providers/image_loading_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: kIsWeb, // Enable device preview hanya di web version
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Setup semua providers yang diperlukan
      providers: [
        ChangeNotifierProvider(create: (_) => ImageLoadingProvider()..preloadImages()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        // Device Preview configuration
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Yummy Food Delivery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4CAF50), // Green color scheme
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade50,
          fontFamily: 'Roboto',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
