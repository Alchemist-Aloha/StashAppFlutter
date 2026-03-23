import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../graphql/graphql_client.dart';

final mediaHeadersProvider = Provider<Map<String, String>>((ref) {
  final apiKey = ref.watch(serverApiKeyProvider);

  if (apiKey.isEmpty) {
    return const <String, String>{};
  }

  return <String, String>{'ApiKey': apiKey};
});
