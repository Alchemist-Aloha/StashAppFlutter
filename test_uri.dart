void main() {
  final graphqlEndpoint = Uri.parse('https://user:pass@host/graphql?token=abc');
  final origin = Uri(
    scheme: graphqlEndpoint.scheme,
    userInfo: graphqlEndpoint.userInfo,
    host: graphqlEndpoint.host,
    port: graphqlEndpoint.hasPort ? graphqlEndpoint.port : null,
    queryParameters: graphqlEndpoint.queryParameters.isEmpty ? null : graphqlEndpoint.queryParameters,
  );
  print('Origin: $origin');
  final value = '/scene/1/stream';
  final result = origin.resolveUri(Uri.parse(value)).toString();
  print('Result: $result');
}
