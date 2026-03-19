import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../preferences/shared_preferences_provider.dart';

part 'graphql_client.g.dart';

Uri _withGraphqlPathIfMissing(Uri uri) {
  final path = uri.path.trim();
  if (path.isEmpty || path == '/') {
    return uri.replace(path: '/graphql');
  }
  return uri;
}

String normalizeGraphqlServerUrl(String url) {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return '';

  final direct = Uri.tryParse(trimmed);
  if (direct != null && direct.hasScheme && direct.host.isNotEmpty) {
    return _withGraphqlPathIfMissing(direct).toString();
  }

  final withHttps = Uri.tryParse('https://$trimmed');
  if (withHttps != null && withHttps.host.isNotEmpty) {
    return _withGraphqlPathIfMissing(withHttps).toString();
  }

  return '';
}

@riverpod
GraphQLClient graphqlClient(Ref ref) {
  // Default settings for development/testing. Remove or override in production.
  const defaultServerUrl = 'http://localhost:9999/graphql';
  const defaultApiKey = '';

  final prefs = ref.watch(sharedPreferencesProvider);
  final storedServerUrl = prefs.getString('server_base_url')?.trim() ?? '';
  final storedApiKey = prefs.getString('server_api_key')?.trim() ?? '';
  final normalizedServerUrl = normalizeGraphqlServerUrl(storedServerUrl);

  final serverUrl = normalizedServerUrl.isEmpty
      ? defaultServerUrl
      : normalizedServerUrl;
  final apiKey = storedApiKey.isEmpty ? defaultApiKey : storedApiKey;

  final HttpLink httpLink = HttpLink(
    serverUrl,
    defaultHeaders: {'ApiKey': apiKey},
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
