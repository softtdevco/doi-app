import 'dart:async';

import 'package:doi_mobile/core/utils/logger.dart';
import 'package:doi_mobile/data/inapp_purchase/inapp_purchase_service.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/data/model/product_model.dart';
import 'package:doi_mobile/presentation/features/dashboard/home/presentation/notifiers/in_app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPNotifier extends Notifier<IAPState> {
  IAPNotifier();

  late IAPService _iapService;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  IAPState build() {
    _iapService = ref.read(iapServiceProvider);

    //initialize();

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return IAPState.initial();
  }

  Future<void> initialize() async {
    await _iapService.initialize();

    state = state.copyWith(
      isAvailable: _iapService.isAvailable,
      products: _iapService.products,
      error: _iapService.error,
    );

    _subscription = _iapService.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () {
        debugLog('Purchase stream done');
        _subscription?.cancel();
      },
      onError: (error) {
        debugLog('Purchase stream error: $error');
        state = state.copyWith(error: error.toString());
      },
    );

    debugLog(
        'IAPNotifier initialized - Available: ${state.isAvailable}, Products: ${state.products.length}');
  }

  Future<void> _onPurchaseUpdate(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final purchase in purchaseDetailsList) {
      debugLog(
          'Purchase update received: ${purchase.productID} - Status: ${purchase.status}');

      if (purchase.status == PurchaseStatus.pending) {
        debugLog('Purchase pending: ${purchase.productID}');
        state = state.copyWith(isPending: true);
      } else {
        if (purchase.status == PurchaseStatus.error) {
          debugLog('Purchase error: ${purchase.error?.message}');
          state = state.copyWith(
            error: purchase.error?.message ?? 'An unknown error occurred',
            isPending: false,
          );
        } else if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          debugLog('Purchase successful: ${purchase.productID}');

          final updatedInventory = Map<String, int>.from(state.inventory);

          if (purchase.productID == ProductIds.freezeTime) {
            updatedInventory[ProductIds.freezeTime] =
                (updatedInventory[ProductIds.freezeTime] ?? 0) + 1;
            debugLog(
                'Added Freeze Time to inventory. New count: ${updatedInventory[ProductIds.freezeTime]}');
          } else if (purchase.productID == ProductIds.revealDigit) {
            updatedInventory[ProductIds.revealDigit] =
                (updatedInventory[ProductIds.revealDigit] ?? 0) + 1;
            debugLog(
                'Added Reveal Digit to inventory. New count: ${updatedInventory[ProductIds.revealDigit]}');
          } else if (purchase.productID == ProductIds.coins) {
            updatedInventory[ProductIds.coins] =
                (updatedInventory[ProductIds.coins] ?? 0) + 1;
            debugLog(
                'Added Reveal Digit to inventory. New count: ${updatedInventory[ProductIds.revealDigit]}');
          } else {
            debugLog('Unknown product purchased: ${purchase.productID}');
          }

          state = state.copyWith(
            inventory: updatedInventory,
            isPending: false,
            error: null,
          );

          await _iapService.completePurchase(purchase);
        } else if (purchase.status == PurchaseStatus.canceled) {
          debugLog('Purchase canceled: ${purchase.productID}');
          state = state.copyWith(isPending: false);
        }
      }
    }
  }

  Future<void> buyProduct({
    required String productId,
    required void Function(String) onError,
    required void Function() onCompleted,
  }) async {
    try {
      debugLog('Initiating purchase for: $productId');
      state = state.copyWith(isPending: true, error: null);

      final result = await _iapService.buyProduct(productId);

      if (!result) {
        debugLog('Purchase initialization failed for: $productId');
        state = state.copyWith(
          isPending: false,
          error: _iapService.error ?? 'Purchase failed to initialize',
        );
        onError(_iapService.error ?? 'Purchase failed to initialize');
        return;
      }

      debugLog('Purchase successfully initiated for: $productId');

      onCompleted();
    } catch (e) {
      debugLog('Error in buyProduct: $e');
      state = state.copyWith(
        isPending: false,
        error: e.toString(),
      );
      onError(e.toString());
    }
  }

  Future<void> restorePurchases() async {
    try {
      debugLog('Restoring purchases...');
      state = state.copyWith(isPending: true, error: null);
      await _iapService.restorePurchases();
    } catch (e) {
      debugLog('Error restoring purchases: $e');
      state = state.copyWith(
        isPending: false,
        error: e.toString(),
      );
    }
  }

  void useItem(String productId) {
    final updatedInventory = Map<String, int>.from(state.inventory);
    final currentCount = updatedInventory[productId] ?? 0;

    if (currentCount > 0) {
      updatedInventory[productId] = currentCount - 1;
      debugLog('Used item: $productId. Remaining: ${currentCount - 1}');
      state = state.copyWith(inventory: updatedInventory);
    } else {
      debugLog('Attempted to use item with zero count: $productId');
    }
  }

  int getItemCount(String productId) {
    return state.inventory[productId] ?? 0;
  }

  String getPrice(String productId) {
    final product = _iapService.getProduct(productId);
    return product?.price ?? 'N/A';
  }
}

final inAppNotifierProvider =
    NotifierProvider<IAPNotifier, IAPState>(IAPNotifier.new);
