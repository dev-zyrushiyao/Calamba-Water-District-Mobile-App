// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AccountNotifier)
final accountProvider = AccountNotifierProvider._();

final class AccountNotifierProvider
    extends $NotifierProvider<AccountNotifier, Set<UserAccount>> {
  AccountNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountNotifierHash();

  @$internal
  @override
  AccountNotifier create() => AccountNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<UserAccount> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<UserAccount>>(value),
    );
  }
}

String _$accountNotifierHash() => r'8c550afe22b4fe2ec943cd3869588adfd318e140';

abstract class _$AccountNotifier extends $Notifier<Set<UserAccount>> {
  Set<UserAccount> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<UserAccount>, Set<UserAccount>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<UserAccount>, Set<UserAccount>>,
              Set<UserAccount>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
