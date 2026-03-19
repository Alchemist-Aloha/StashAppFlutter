// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(groupList)
final groupListProvider = GroupListProvider._();

final class GroupListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Group>>,
          List<Group>,
          FutureOr<List<Group>>
        >
    with $FutureModifier<List<Group>>, $FutureProvider<List<Group>> {
  GroupListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupListHash();

  @$internal
  @override
  $FutureProviderElement<List<Group>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Group>> create(Ref ref) {
    return groupList(ref);
  }
}

String _$groupListHash() => r'72a0e00a4e2759799f40d5512c8506dd18610b91';
