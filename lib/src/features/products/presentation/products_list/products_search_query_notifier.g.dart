// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_search_query_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsSearchResultsHash() =>
    r'a60ecb7096cc8e59e5a9ba5a91e1ce6017451eec';

/// See also [productsSearchResults].
@ProviderFor(productsSearchResults)
final productsSearchResultsProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
  productsSearchResults,
  name: r'productsSearchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsSearchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsSearchResultsRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$productsSearchQueryNotifierHash() =>
    r'308060397076bc2d8b5156a3c72d8ab86c8dad03';

/// See also [ProductsSearchQueryNotifier].
@ProviderFor(ProductsSearchQueryNotifier)
final productsSearchQueryNotifierProvider =
    AutoDisposeNotifierProvider<ProductsSearchQueryNotifier, String>.internal(
  ProductsSearchQueryNotifier.new,
  name: r'productsSearchQueryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsSearchQueryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductsSearchQueryNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
