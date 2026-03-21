import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<HttpClient>((ref) {
  final client = HttpClient();
  client.connectionTimeout = const Duration(seconds: 3);

  ref.onDispose(() {
    client.close(force: true);
  });

  return client;
});
