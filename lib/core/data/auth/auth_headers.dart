import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'auth_mode.dart';
import 'auth_provider.dart';

Map<String, String> getAuthHeaders({
  required AuthState authState,
  required String apiKey,
}) {
  final headers = <String, String>{};

  // 1. Stash Header (ApiKey) - highest priority
  if (apiKey.isNotEmpty) {
    headers['ApiKey'] = apiKey;
  }

  // 2. Authorization Header (Bearer or Basic)
  if (authState.mode == AuthMode.bearer && apiKey.isNotEmpty) {
    headers['Authorization'] = 'Bearer $apiKey';
  } else if (authState.mode == AuthMode.basic) {
    final user = authState.username.trim();
    final pass = authState.password;
    if (user.isNotEmpty || pass.isNotEmpty) {
      final bytes = utf8.encode('$user:$pass');
      final base64 = base64Encode(bytes);
      headers['Authorization'] = 'Basic $base64';
    }
  }

  // 3. Cookie (for password mode)
  if (authState.mode == AuthMode.password) {
    // Browsers treat Cookie as a forbidden request header. For web we rely
    // on credentials-enabled requests instead of manually setting Cookie.
    if (!kIsWeb && authState.cookieHeader.isNotEmpty) {
      headers['Cookie'] = authState.cookieHeader;
    }
  }

  return headers;
}
