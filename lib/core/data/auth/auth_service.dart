import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AuthService {
  AuthService({required Dio dio, required this.cookieJar}) : _dio = dio;

  static Future<PersistCookieJar>? _sharedCookieJarFuture;

  final Dio _dio;
  final PersistCookieJar cookieJar;

  static Future<AuthService> create() async {
    final cookieJar = await createPersistCookieJar();

    final dio = Dio()
      ..interceptors.add(CookieManager(cookieJar))
      ..options.followRedirects = true
      ..options.validateStatus = (status) =>
          status != null && status >= 200 && status < 500;

    return AuthService(dio: dio, cookieJar: cookieJar);
  }

  static Future<PersistCookieJar> createPersistCookieJar() async {
    _sharedCookieJarFuture ??= () async {
      final supportDir = await getApplicationSupportDirectory();
      final cookiePath = p.join(supportDir.path, 'stashflow_cookies');
      return PersistCookieJar(
        ignoreExpires: false,
        storage: FileStorage(cookiePath),
      );
    }();

    return _sharedCookieJarFuture!;
  }

  Dio get dio => _dio;

  Future<bool> login({
    required Uri graphqlEndpoint,
    required String username,
    required String password,
  }) async {
    final trimmedUsername = username.trim();
    if (trimmedUsername.isEmpty || password.isEmpty) {
      return false;
    }

    final loginUri = _resolveEndpoint(graphqlEndpoint, 'login');
    final response = await _dio.postUri(
      loginUri,
      data: <String, String>{
        'username': trimmedUsername,
        'password': password,
        'returnURL': '/',
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: <String, String>{HttpHeaders.acceptHeader: '*/*'},
      ),
    );

    return response.statusCode == 200;
  }

  Future<void> logout({required Uri graphqlEndpoint}) async {
    final logoutUri = _resolveEndpoint(graphqlEndpoint, 'logout');
    try {
      await _dio.getUri(logoutUri);
    } catch (_) {
      // Best effort endpoint call; always clear local cookie state.
    }

    await clearCookies();
  }

  Future<void> clearCookies() => cookieJar.deleteAll();

  Future<String> cookieHeaderFor({required Uri requestUri}) async {
    final cookies = await cookieJar.loadForRequest(requestUri);
    if (cookies.isEmpty) {
      return '';
    }

    return cookies
        .where((cookie) => cookie.name.isNotEmpty)
        .map((cookie) => '${cookie.name}=${cookie.value}')
        .join('; ')
        .trim();
  }

  Uri _resolveEndpoint(Uri endpoint, String route) {
    final segments = endpoint.pathSegments
        .where((segment) => segment.isNotEmpty)
        .toList();

    if (segments.isNotEmpty && segments.last.toLowerCase() == 'graphql') {
      segments[segments.length - 1] = route;
    } else {
      segments.add(route);
    }

    return endpoint.replace(
      pathSegments: segments,
      query: null,
      fragment: null,
    );
  }
}
