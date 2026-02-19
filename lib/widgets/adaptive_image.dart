import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Widget untuk menampilkan image yang bisa handle local assets dan network images
class AdaptiveImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AdaptiveImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  // Check apakah imageUrl adalah local asset
  bool get isLocalAsset {
    return imageUrl.startsWith('assets/');
  }

  @override
  Widget build(BuildContext context) {
    if (isLocalAsset) {
      // Gunakan Image.asset untuk local assets
      // Image.asset tidak punya loadingBuilder, jadi kita gunakan frameBuilder untuk loading state
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded || frame != null) {
            return child;
          }
          return placeholder ??
              Container(
                width: width,
                height: height,
                color: Colors.grey.shade200,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ??
              Container(
                width: width,
                height: height,
                color: Colors.grey.shade200,
                child: const Icon(Icons.error),
              );
        },
      );
    } else {
      // Gunakan CachedNetworkImage untuk network images
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context, url) => placeholder ??
            Container(
              width: width,
              height: height,
              color: Colors.grey.shade200,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        errorWidget: (context, url, error) => errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey.shade200,
              child: const Icon(Icons.error),
            ),
      );
    }
  }
}

