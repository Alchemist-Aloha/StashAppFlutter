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
class SharedPreferencesTrigger extends _$SharedPreferencesTrigger {
  @override
  int build() => 0;
  void trigger() => state++;
}

@riverpod
String serverUrl(Ref ref) {
  ref.watch(sharedPreferencesTriggerProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  final storedServerUrl = prefs.getString('server_base_url')?.trim() ?? '';
  return normalizeGraphqlServerUrl(storedServerUrl);
}

@riverpod
String serverApiKey(Ref ref) {
  ref.watch(sharedPreferencesTriggerProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString('server_api_key')?.trim() ?? '';
}

@riverpod
GraphQLClient graphqlClient(Ref ref) {
  final url = ref.watch(serverUrlProvider);
  if (url.isEmpty) {
    throw Exception('Server URL not configured');
  }

  final apiKey = ref.watch(serverApiKeyProvider);

  final HttpLink httpLink = HttpLink(
    url,
    defaultHeaders: {'ApiKey': apiKey},
  );

  return GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );
}
