import 'package:flutter/material.dart';

class ProductNetworkImage extends StatelessWidget {
  const ProductNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        final totalBytes = loadingProgress.expectedTotalBytes;
        final progress = totalBytes == null
            ? null
            : loadingProgress.cumulativeBytesLoaded / totalBytes;

        return Container(
          width: width,
          height: height,
          color: Colors.grey[100],
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            value: progress,
            color: Colors.indigo,
            strokeWidth: 2.5,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[100],
          alignment: Alignment.center,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.broken_image_outlined, color: Colors.grey, size: 36),
              SizedBox(height: 6),
              Text(
                'Image unavailable',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
