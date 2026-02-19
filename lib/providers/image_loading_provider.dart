import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

/// Provider untuk track loading state images
class ImageLoadingProvider with ChangeNotifier {
  bool _isLoading = true;
  int _loadedImages = 0;
  int _totalImages = 0;

  bool get isLoading => _isLoading;
  int get loadedImages => _loadedImages;
  int get totalImages => _totalImages;

  // Method untuk preload semua images
  Future<void> preloadImages() async {
    _isLoading = true;
    _loadedImages = 0;
    notifyListeners();

    // List semua asset images yang perlu di-load
    final imageAssets = [
      'assets/images/category_avocado.png',
      'assets/images/category_almonds.png',
      'assets/images/category_broccoli.png',
      'assets/images/category_vegetables.png',
      'assets/images/avocado_wrap.png',
      'assets/images/garden_salad.png',
      'assets/images/green_pea_bowl.png',
      'assets/images/organic_broccoli.png',
      'assets/images/roasted_almonds.png',
    ];

    _totalImages = imageAssets.length;

    // Preload semua images dengan error handling
    final List<Future<void>> loadFutures = [];
    
    for (final asset in imageAssets) {
      loadFutures.add(
        _loadImage(asset),
      );
    }

    // Wait semua images selesai di-load
    await Future.wait(loadFutures);

    // Tambahkan delay minimal 2 detik untuk splash screen
    await Future.delayed(const Duration(milliseconds: 2000));

    _isLoading = false;
    notifyListeners();
  }

  // Helper method untuk load single image
  Future<void> _loadImage(String asset) async {
    try {
      final byteData = await rootBundle.load(asset);
      final codec = await ui.instantiateImageCodec(
        byteData.buffer.asUint8List(),
      );
      await codec.getNextFrame();
      _loadedImages++;
      notifyListeners();
    } catch (e) {
      // Jika error, tetap increment untuk menghindari stuck
      _loadedImages++;
      notifyListeners();
    }
  }
}

