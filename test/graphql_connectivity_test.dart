import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  const serverUrl = String.fromEnvironment(
    'TEST_GRAPHQL_URL',
    defaultValue: 'https://stash.cai.co.im/graphql',
  );
  const apiKey = String.fromEnvironment(
    'TEST_GRAPHQL_API_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiJxbWtreGNsayIsInN1YiI6IkFQSUtleSIsImlhdCI6MTc3Mzc5MjkyNX0.611H2b2FvizfvU7ooAPW7H6b-u7SU0lI2hvZ34u78t0',
  );

  test('can connect to GraphQL API and execute a network query', () async {
    final client = GraphQLClient(
      link: HttpLink(
        serverUrl,
        defaultHeaders: <String, String>{'ApiKey': apiKey},
      ),
      cache: GraphQLCache(store: InMemoryStore()),
    );

    final result = await client.query(
      QueryOptions(
        document: gql('query ConnectivityCheck { __typename }'),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    expect(
      result.hasException,
      isFalse,
      reason: result.exception?.toString() ?? 'Unknown GraphQL exception',
    );
    expect(result.data, isNotNull);
    expect(result.data!['__typename'], isNotNull);
  });
}
