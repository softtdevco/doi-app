import 'package:doi_mobile/core/utils/colors.dart';
import 'package:doi_mobile/data/third_party_services/ads_service.dart';
import 'package:doi_mobile/presentation/general_widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final double width;
  final double height;

  const BannerAdWidget({
    Key? key,
    this.width = 320,
    this.height = 50,
  }) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  final AdManager _adManager = AdManager();
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _adManager.loadBannerAd(
      size: AdSize.banner, // Standard 320x50 banner
      onAdLoaded: (ad) {
        if (mounted) {
          setState(() {
            _isAdLoaded = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFF979797),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      child: _isAdLoaded && _adManager.bannerAd != null
          ? AdWidget(ad: _adManager.bannerAd!)
          : const Center(
              child: AppLoader(
                color: AppColors.primaryColor,
              ),
            ),
    );
  }

  @override
  void dispose() {
    // Note: Don't dispose the banner ad here as it's managed by AdManager
    super.dispose();
  }
}
