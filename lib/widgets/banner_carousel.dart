import 'dart:async';
import 'package:flutter/material.dart';

/// Ana sayfanın üstünde otomatik kayan tanıtım banner'ı.
///
/// `PageView` + `Timer.periodic` ile her 3 saniyede bir otomatik geçiş
/// yapar; kullanıcı manuel olarak da kaydırabilir.
class BannerCarousel extends StatefulWidget {
  final List<String> imageAssets;

  const BannerCarousel({super.key, required this.imageAssets});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % widget.imageAssets.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.imageAssets.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(widget.imageAssets[index], fit: BoxFit.cover, width: double.infinity),
                ),
              );
            },
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.imageAssets.length, (index) {
                final isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(isActive ? 0.95 : 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
