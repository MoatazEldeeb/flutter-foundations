// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartServiceHash() => r'81bf6391bc62e1f6c608c0aac88f2a3f0e711e34';

/// See also [cartService].
@ProviderFor(cartService)
final cartServiceProvider = Provider<CartService>.internal(
  cartService,
  name: r'cartServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartServiceRef = ProviderRef<CartService>;
String _$cartHash() => r'8c55e19ee78a30cecb0d2b076ce688f11e9d5c1a';

/// See also [cart].
@ProviderFor(cart)
final cartProvider = StreamProvider<Cart>.internal(
  cart,
  name: r'cartProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartRef = StreamProviderRef<Cart>;
String _$cartItemsCountHash() => r'c8d67d2c5fa13d83da6dec350bca0418820ad8d8';

/// See also [cartItemsCount].
@ProviderFor(cartItemsCount)
final cartItemsCountProvider = Provider<int>.internal(
  cartItemsCount,
  name: r'cartItemsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartItemsCountRef = ProviderRef<int>;
String _$cartTotalHash() => r'0834f7e0b7a288e2e847958be8919792afe6720c';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeFutureProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CartTotalRef = AutoDisposeFutureProviderRef<double>;
String _$itemAvailableQuantityHash() =>
    r'bf8ea212feaa0322b97753a9a241cbd1da278c2f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [itemAvailableQuantity].
@ProviderFor(itemAvailableQuantity)
const itemAvailableQuantityProvider = ItemAvailableQuantityFamily();

/// See also [itemAvailableQuantity].
class ItemAvailableQuantityFamily extends Family<int> {
  /// See also [itemAvailableQuantity].
  const ItemAvailableQuantityFamily();

  /// See also [itemAvailableQuantity].
  ItemAvailableQuantityProvider call(
    Product product,
  ) {
    return ItemAvailableQuantityProvider(
      product,
    );
  }

  @override
  ItemAvailableQuantityProvider getProviderOverride(
    covariant ItemAvailableQuantityProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemAvailableQuantityProvider';
}

/// See also [itemAvailableQuantity].
class ItemAvailableQuantityProvider extends AutoDisposeProvider<int> {
  /// See also [itemAvailableQuantity].
  ItemAvailableQuantityProvider(
    Product product,
  ) : this._internal(
          (ref) => itemAvailableQuantity(
            ref as ItemAvailableQuantityRef,
            product,
          ),
          from: itemAvailableQuantityProvider,
          name: r'itemAvailableQuantityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemAvailableQuantityHash,
          dependencies: ItemAvailableQuantityFamily._dependencies,
          allTransitiveDependencies:
              ItemAvailableQuantityFamily._allTransitiveDependencies,
          product: product,
        );

  ItemAvailableQuantityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    int Function(ItemAvailableQuantityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemAvailableQuantityProvider._internal(
        (ref) => create(ref as ItemAvailableQuantityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _ItemAvailableQuantityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemAvailableQuantityProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemAvailableQuantityRef on AutoDisposeProviderRef<int> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _ItemAvailableQuantityProviderElement
    extends AutoDisposeProviderElement<int> with ItemAvailableQuantityRef {
  _ItemAvailableQuantityProviderElement(super.provider);

  @override
  Product get product => (origin as ItemAvailableQuantityProvider).product;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
