import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/image_loading_provider.dart';
import 'home_screen.dart';

/// Splash screen dengan logo "Yummy" dan food bowl illustration
/// Akan tetap muncul sampai semua images selesai loading
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Listen ke image loading provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final imageProvider = Provider.of<ImageLoadingProvider>(context, listen: false);
      imageProvider.addListener(_onImageLoadingChanged);
      // Jika sudah tidak loading, langsung navigate
      if (!imageProvider.isLoading) {
        _navigateToHome();
      }
    });
  }

  void _onImageLoadingChanged() {
    if (mounted) {
      final imageProvider = Provider.of<ImageLoadingProvider>(context, listen: false);
      if (!imageProvider.isLoading) {
        imageProvider.removeListener(_onImageLoadingChanged);
        _navigateToHome();
      }
    }
  }

  void _navigateToHome() {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    final imageProvider = Provider.of<ImageLoadingProvider>(context, listen: false);
    imageProvider.removeListener(_onImageLoadingChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BC34A), // Lime green color
      body: Consumer<ImageLoadingProvider>(
        builder: (context, imageProvider, child) {
          return Stack(
            children: [
              // Food bowl illustration di top right (simulated dengan icon)
              Positioned(
                top: 40,
                right: 20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.restaurant,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              // "Yummy" text di center
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Yummy',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Loading indicator - hanya muncul saat masih loading
                    if (imageProvider.isLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

