import 'package:doi_mobile/core/utils/enums.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPState {
  final bool isAvailable;
  final bool isPending;
  final LoadState loadState;
  final List<ProductDetails> products;
  final String? error;
  final Map<String, int> inventory;

  IAPState({
    required this.isAvailable,
    required this.isPending,
    required this.products,
    this.error,
    required this.inventory,
    required this.loadState,
  });

  factory IAPState.initial() {
    return IAPState(
      isAvailable: false,
      isPending: false,
      products: [],
      inventory: {},
      loadState: LoadState.idle,
    );
  }

  IAPState copyWith({
    bool? isAvailable,
    bool? isPending,
    List<ProductDetails>? products,
    String? error,
    Map<String, int>? inventory,
    LoadState? loadState,  
  }) {
    return IAPState(
      isAvailable: isAvailable ?? this.isAvailable,
      isPending: isPending ?? this.isPending,
      products: products ?? this.products,
      error: error,
      inventory: inventory ?? this.inventory,
      loadState: loadState ?? this.loadState,
    );
  }
}
