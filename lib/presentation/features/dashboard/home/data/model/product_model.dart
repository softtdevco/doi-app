import 'package:doi_mobile/gen/assets.gen.dart';

enum ProductType { powerUp, coin }

class ProductInfo {
  final String id;
  final String displayName;
  final ProductType type;
  final String iconPath;
  final String description;
  final bool isConsumable;

  const ProductInfo({
    required this.id,
    required this.displayName,
    required this.type,
    required this.iconPath,
    required this.description,
    required this.isConsumable,
  });
}

class ProductIds {
  // Power-ups
  static const String freezeTime = 'pwp_freezetime';
  static const String revealDigit = 'pwp_reveal1digit';
  static const String swapCode = 'swap_pwp';

  // Other product types
  static const String coins = 'coins';

  // All product IDs that should be loaded from the store
  static List<String> get all => [freezeTime, revealDigit, swapCode, coins];

  // Mapping of product IDs to their information
  static final Map<String, ProductInfo> productInfo = {
    freezeTime: ProductInfo(
      id: freezeTime,
      displayName: 'Freeze Time',
      type: ProductType.powerUp,
      iconPath: Assets.svgs.freezeTime,
      description: 'Freezes the timer for 30 seconds',
      isConsumable: true,
    ),
    revealDigit: ProductInfo(
      id: revealDigit,
      displayName: 'Reveal 1 Digit',
      type: ProductType.powerUp,
      iconPath: Assets.svgs.reveal,
      description: 'Reveals one digit on the board',
      isConsumable: true,
    ),
    coins: ProductInfo(
      id: coins,
      displayName: 'Coins',
      type: ProductType.coin,
      iconPath: Assets.svgs.coin,
      description: 'Buy Coins',
      isConsumable: true,
    ),
  };

  // Helper methods to get products by type
  static List<String> getPowerUpIds() {
    return productInfo.entries
        .where((entry) => entry.value.type == ProductType.powerUp)
        .map((entry) => entry.key)
        .toList();
  }

  static List<String> getNonConsumableIds() {
    return productInfo.entries
        .where((entry) => !entry.value.isConsumable)
        .map((entry) => entry.key)
        .toList();
  }

  static bool isConsumable(String productId) {
    return productInfo[productId]?.isConsumable ?? false;
  }
}
