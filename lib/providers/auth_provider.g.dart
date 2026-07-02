// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthNotifier)
final authProvider = AuthNotifierProvider._();

final class AuthNotifierProvider
    extends $NotifierProvider<AuthNotifier, UserAccount?> {
  AuthNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authNotifierHash();

  @$internal
  @override
  AuthNotifier create() => AuthNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAccount? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAccount?>(value),
    );
  }
}

String _$authNotifierHash() => r'214878843f842f9fa41d184e801836055beaf904';

abstract class _$AuthNotifier extends $Notifier<UserAccount?> {
  UserAccount? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UserAccount?, UserAccount?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserAccount?, UserAccount?>,
              UserAccount?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
