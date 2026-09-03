import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stash_app_flutter/core/data/graphql/deferred_graphql_store.dart';

void main() {
  test('merges startup writes over existing persistent entries', () {
    final store = DeferredGraphqlStore();
    store.put('updated', {'value': 'startup'});
    store.put('new', {'value': 2});

    final persistent = InMemoryStore({
      'updated': {'value': 'disk'},
      'retained': {'value': 1},
    });
    store.attach(persistent);

    expect(store.isAttached, isTrue);
    expect(store.get('updated'), {'value': 'startup'});
    expect(store.get('new'), {'value': 2});
    expect(store.get('retained'), {'value': 1});
  });

  test('replays startup deletes when persistent storage attaches', () {
    final store = DeferredGraphqlStore();
    store.delete('removed');

    final persistent = InMemoryStore({
      'removed': {'value': 1},
      'retained': {'value': 2},
    });
    store.attach(persistent);

    expect(store.get('removed'), isNull);
    expect(store.get('retained'), {'value': 2});
  });

  test('replays a startup reset before merging later writes', () {
    final store = DeferredGraphqlStore();
    store.reset();
    store.put('new', {'value': 2});

    final persistent = InMemoryStore({
      'old': {'value': 1},
    });
    store.attach(persistent);

    expect(store.get('old'), isNull);
    expect(store.get('new'), {'value': 2});
  });
}
