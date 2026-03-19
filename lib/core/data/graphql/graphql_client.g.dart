// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graphql_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(graphqlClient)
final graphqlClientProvider = GraphqlClientProvider._();

final class GraphqlClientProvider
    extends $FunctionalProvider<GraphQLClient, GraphQLClient, GraphQLClient>
    with $Provider<GraphQLClient> {
  GraphqlClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'graphqlClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$graphqlClientHash();

  @$internal
  @override
  $ProviderElement<GraphQLClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GraphQLClient create(Ref ref) {
    return graphqlClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GraphQLClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GraphQLClient>(value),
    );
  }
}

String _$graphqlClientHash() => r'ee33d8d5ca95bd0363e533c9447a34580d164cf9';
