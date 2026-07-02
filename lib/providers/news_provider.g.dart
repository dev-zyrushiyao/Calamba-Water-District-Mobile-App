// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsNotifier)
final newsProvider = NewsNotifierProvider._();

final class NewsNotifierProvider
    extends $NotifierProvider<NewsNotifier, List<News>> {
  NewsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newsNotifierHash();

  @$internal
  @override
  NewsNotifier create() => NewsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<News> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<News>>(value),
    );
  }
}

String _$newsNotifierHash() => r'20dadc15019fab7f7125b736d805343696d2c6b5';

abstract class _$NewsNotifier extends $Notifier<List<News>> {
  List<News> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<News>, List<News>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<News>, List<News>>,
              List<News>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
