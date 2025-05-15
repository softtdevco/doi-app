import 'dart:async';

import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPService {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  Stream<List<PurchaseDetails>> get purchaseStream =>
      _inAppPurchase.purchaseStream;

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  bool _purchasePending = false;
  bool get purchasePending => _purchasePending;

  bool _isAvailable = false;
  bool get isAvailable => _isAvailable;

  String? _error;
  String? get error => _error;

  Future<void> initialize() async {
    try {
      _isAvailable = await _inAppPurchase.isAvailable();

      if (!_isAvailable) {
        _error = 'Store is not available.';
        return;
      }

      await loadProducts();

      debugLog(
          'IAP initialized - Store available: $_isAvailable, Products: ${_products.length}');
    } catch (e) {
      _isAvailable = false;
      _error = 'Error initializing in-app purchases: $e';
      debugLog(_error!);
    }
  }

  Future<void> loadProducts() async {
    try {
      debugLog('Loading products: ${ProductIds.all}');
      final ProductDetailsResponse response =
          await _inAppPurchase.queryProductDetails(ProductIds.all.toSet());

      if (response.notFoundIDs.isNotEmpty) {
        debugLog('Products not found: ${response.notFoundIDs}');
      }

      _products = response.productDetails;
      debugLog('Loaded ${_products.length} products');

      for (var product in _products) {
        debugLog('Product: ${product.id}, Price: ${product.price}');
      }
    } catch (e) {
      _error = e.toString();
      debugLog('Error loading products: $e');
    }
  }

  Future<bool> buyProduct(String productId) async {
    if (_purchasePending) {
      debugLog('Purchase already pending for: $productId');
      return false;
    }

    if (!_isAvailable) {
      debugLog('Store is not available');
      _error = 'Store is not available';
      return false;
    }

    if (_products.isEmpty) {
      debugLog('Product list is empty, reloading...');
      await loadProducts();

      if (_products.isEmpty) {
        debugLog('No products available after reload');
        _error = 'No products available';
        return false;
      }
    }

    ProductDetails product;
    bool isTargetProduct = true;

    try {
      product = _products.firstWhere((p) => p.id == productId);
      debugLog('Found product: ${product.id}, Price: ${product.price}');
    } catch (e) {
      debugLog(
          'Product not found in cache: $productId, using fallback product');

      if (_products.isEmpty) {
        debugLog('No products available for fallback');
        _error = 'No products available';
        return false;
      }

      product = _products.first;
      isTargetProduct = false;
      debugLog('Using fallback product: ${product.id} for UI');
    }

    try {
      _purchasePending = true;
      debugLog(
          'Starting purchase for: ${isTargetProduct ? productId : product.id + " (as proxy for " + productId + ")"}');

      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: product,
        applicationUserName: null,
      );

      // Determine if the product is consumable based on our product info
      bool isConsumable = ProductIds.isConsumable(productId);

      if (isConsumable) {
        debugLog('Buying as consumable: $productId');
        return await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
      } else {
        debugLog('Buying as non-consumable: $productId');
        return await _inAppPurchase.buyNonConsumable(
            purchaseParam: purchaseParam);
      }
    } catch (e) {
      _error = e.toString();
      _purchasePending = false;
      debugLog('Error initiating purchase: $e');
      return false;
    }
  }

  Future<void> completePurchase(PurchaseDetails purchase) async {
    try {
      if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        debugLog('Processing successful purchase: ${purchase.productID}');
        await _deliverProduct(purchase);

        if (purchase.pendingCompletePurchase) {
          debugLog('Completing purchase for ${purchase.productID}');
          await _inAppPurchase.completePurchase(purchase);
        }
      }
    } catch (e) {
      debugLog('Error completing purchase: $e');
      _error = e.toString();
    } finally {
      _purchasePending = false;
    }
  }

  Future<void> _deliverProduct(PurchaseDetails purchase) async {
    debugLog('Delivering product: ${purchase.productID}');

    final productInfo = ProductIds.productInfo[purchase.productID];
    if (productInfo != null) {
      switch (productInfo.type) {
        case ProductType.powerUp:
          debugLog('Power-up delivered: ${productInfo.displayName}');
          break;

        case ProductType.coin:
          debugLog('Theme unlocked: ${productInfo.displayName}');
          break;
      }
    } else {
      debugLog('Unknown product delivered: ${purchase.productID}');
    }
  }

  Future<void> restorePurchases() async {
    try {
      debugLog('Restoring purchases...');
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      debugLog('Error restoring purchases: $e');
      _error = e.toString();
    }
  }

  ProductDetails? getProduct(String productId) {
    try {
      return _products.firstWhere((product) => product.id == productId);
    } catch (e) {
      debugLog('Product not found in getProduct: $productId');
      return null;
    }
  }
}

final iapServiceProvider = Provider<IAPService>((ref) {
  final service = IAPService();
  return service;
});
