import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'graphql_client.g.dart';

@riverpod
GraphQLClient graphqlClient(Ref ref) {
  // TODO: Fetch from shared preferences (later)
  // Hardcoded for development
  const serverUrl = 'http://localhost:9999/graphql';
  const apiKey = '';

  final HttpLink httpLink = HttpLink(
    serverUrl,
    defaultHeaders: {
      'ApiKey': apiKey,
    },
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
