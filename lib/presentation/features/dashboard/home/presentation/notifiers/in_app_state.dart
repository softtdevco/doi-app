import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

@immutable
class IAPState {
  final bool isAvailable;
  final bool isPending;
  final List<ProductDetails> products;

  final Map<String, int> inventory;
  final Map<String, int> coin;
  final Set<String> ownedProducts;
  final Map<String, DateTime> subscriptions;
  
  final String? error;

  const IAPState({
    required this.isAvailable,
    required this.isPending,
    required this.products,
    required this.inventory,
    required this.coin,
    required this.ownedProducts,
    required this.subscriptions,
    this.error,
  });

  factory IAPState.initial() {
    return const IAPState(
      isAvailable: false,
      isPending: false,
      products: [],
      inventory: {},
      coin: {},
      ownedProducts: {},
      subscriptions: {},
      error: null,
    );
  }

  IAPState copyWith({
    bool? isAvailable,
    bool? isPending,
    List<ProductDetails>? products,
    Map<String, int>? inventory,
    Map<String, int>? coin,
    Set<String>? ownedProducts,
    Map<String, DateTime>? subscriptions,
    String? error,
  }) {
    return IAPState(
      isAvailable: isAvailable ?? this.isAvailable,
      isPending: isPending ?? this.isPending,
      products: products ?? this.products,
      inventory: inventory ?? this.inventory,
      coin: coin ?? this.coin,
      ownedProducts: ownedProducts ?? this.ownedProducts,
      subscriptions: subscriptions ?? this.subscriptions,
      error: error,  
    );
  }

  bool hasProduct(String productId) {

    if (inventory.containsKey(productId) && (inventory[productId] ?? 0) > 0) {
      return true;
    }
    

    if (ownedProducts.contains(productId)) {
      return true;
    }
    
   
    if (subscriptions.containsKey(productId)) {
      final expiryDate = subscriptions[productId];
      if (expiryDate != null && expiryDate.isAfter(DateTime.now())) {
        return true;
      }
    }
    
    return false;
  }

  @override
  String toString() {
    return 'IAPState(isAvailable: $isAvailable, isPending: $isPending, '
        'products: ${products.length}, inventory: $inventory, '
        'ownedProducts: $ownedProducts, subscriptions: $subscriptions, coins: $coin, '
        'error: $error)';
  }
}