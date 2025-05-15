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
  static const String coins = 'coins';
  static const String coinPack1 = 'coinpack_1';
  static const String coinPack2 = 'coinpack_2';
  static const String coinPack3 = 'coinpack_3';

  static List<String> get all => [coinPack1, coins, coinPack2, coinPack3];

  static final Map<String, ProductInfo> productInfo = {
    coins: ProductInfo(
      id: coins,
      displayName: 'Coins',
      type: ProductType.coin,
      iconPath: Assets.svgs.coin,
      description: 'Buy Coins',
      isConsumable: true,
    ),
    coinPack1: ProductInfo(
      id: coins,
      displayName: 'Coins',
      type: ProductType.coin,
      iconPath: Assets.svgs.coin,
      description: 'Buy Coins',
      isConsumable: true,
    ),
    coinPack2: ProductInfo(
      id: coins,
      displayName: 'Coins',
      type: ProductType.coin,
      iconPath: Assets.svgs.coin,
      description: 'Buy Coins',
      isConsumable: true,
    ),
    coinPack3: ProductInfo(
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
