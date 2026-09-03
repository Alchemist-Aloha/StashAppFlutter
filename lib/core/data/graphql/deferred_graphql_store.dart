import 'package:graphql_flutter/graphql_flutter.dart';

/// A GraphQL cache store that can attach persistent storage after startup.
///
/// Reads and writes initially use an in-memory store so opening a disk-backed
/// store cannot delay the first frame. When [attach] is called, existing disk
/// entries are retained and writes made during startup take precedence.
class DeferredGraphqlStore extends Store {
  final _DeferredGraphqlStoreState _state = _DeferredGraphqlStoreState();

  /// Whether a persistent store has been attached.
  bool get isAttached => _state.isAttached;

  /// Attaches [persistentStore] and merges startup mutations into it.
  void attach(Store persistentStore) {
    if (_state.isAttached) return;

    final startupEntries = _state.delegate.toMap();
    if (_state.resetBeforeAttach) {
      persistentStore.reset();
    } else {
      for (final key in _state.pendingDeletes) {
        persistentStore.delete(key);
      }
    }
    persistentStore.putAll(startupEntries);
    _state.delegate = persistentStore;
    _state.pendingDeletes.clear();
    _state.isAttached = true;
  }

  @override
  Map<String, dynamic>? get(String dataId) => _state.delegate.get(dataId);

  @override
  void put(String dataId, Map<String, dynamic>? value) {
    _state.pendingDeletes.remove(dataId);
    _state.delegate.put(dataId, value);
  }

  @override
  void putAll(Map<String, Map<String, dynamic>?> data) {
    _state.pendingDeletes.removeAll(data.keys);
    _state.delegate.putAll(data);
  }

  @override
  void delete(String dataId) {
    if (!_state.isAttached && !_state.resetBeforeAttach) {
      _state.pendingDeletes.add(dataId);
    }
    _state.delegate.delete(dataId);
  }

  @override
  void reset() {
    if (!_state.isAttached) {
      _state.resetBeforeAttach = true;
      _state.pendingDeletes.clear();
    }
    _state.delegate.reset();
  }

  @override
  Map<String, Map<String, dynamic>?> toMap() => _state.delegate.toMap();
}

class _DeferredGraphqlStoreState {
  Store delegate = InMemoryStore();
  final Set<String> pendingDeletes = <String>{};
  bool resetBeforeAttach = false;
  bool isAttached = false;
}
