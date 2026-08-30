import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:poka_ce/core/logger/poka_logger.dart';

base class TalkerRiverpodObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    talker.info('Provider added: ${context.provider.name ?? context.provider.runtimeType} | Value: $value');
  }

  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    talker.info('Provider updated: ${context.provider.name ?? context.provider.runtimeType}');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    talker.info('Provider disposed: ${context.provider.name ?? context.provider.runtimeType}');
  }

  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    talker.handle(error, stackTrace, 'Provider failed: ${context.provider.name ?? context.provider.runtimeType}');
  }
}
