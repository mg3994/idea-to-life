import 'dart:async' show unawaited;

import 'package:bloc_signals_flutter/bloc_signals_flutter.dart';
import 'package:flutter/foundation.dart' show debugPrint;

import '../../../core.dart' show AnalyticsGateway;

class const AppBlocObserver(final AnalyticsGateway? analyticsGateway)
    extends BlocSignalObserver {
  @override
  void onCreate(BlocSignalBase bloc) {
    super.onCreate(bloc);
    unawaited(
      analyticsGateway?.logEvent(
        name: 'bloc_created',
        parameters: {'bloc_name': bloc.runtimeType.toString()},
      ),
    );
    debugPrint('Container Created: ${bloc.runtimeType}');
  }

  @override
  void onEvent(BlocSignalBase bloc, Object? event) {
    super.onEvent(bloc, event);
    unawaited(
      analyticsGateway?.logEvent(
        name: 'bloc_event',
        parameters: {
          'bloc_name': bloc.runtimeType.toString(),
          'event': event.toString(),
        },
      ),
    );
    debugPrint('${bloc.runtimeType} Event: $event');
  }

  @override
  void onChange(BlocSignalBase bloc, Change change) {
    super.onChange(bloc, change);
    unawaited(
      analyticsGateway?.logEvent(
        name: 'bloc_change',
        parameters: {
          'bloc_name': bloc.runtimeType.toString(),
          'current_state': change.currentState.toString(),
          'next_state': change.nextState.toString(),
        },
      ),
    );
    debugPrint(
      '${bloc.runtimeType} Change: ${change.currentState} -> ${change.nextState}',
    );
  }

  @override
  void onTransition(
    BlocSignalBase<dynamic> bloc,
    Object? event,
    Object? state,
  ) {
    // TODO: implement onTransition
    super.onTransition(bloc, event, state);
    unawaited(
      analyticsGateway?.logEvent(
        name: 'bloc_transition',
        parameters: {
          'bloc_name': bloc.runtimeType.toString(),
          'event': event.toString(),
          'state': state.toString(),
        },
      ),
    );
    debugPrint('${bloc.runtimeType} Transition: $event => $state');
  }
  // @override
  // void onTransition(BlocSignal bloc, Transition transition) {
  //   super.onTransition(bloc, transition);
  //   print('${bloc.runtimeType} Transition: ${transition.event} => ${transition.nextState}');
  // }

  @override
  void onError(BlocSignalBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    unawaited(
      analyticsGateway?.logEvent(
        name: 'bloc_error',
        parameters: {
          'bloc_name': bloc.runtimeType.toString(),
          'error': error.toString(),
          'stack_trace': stackTrace.toString(),
        },
      ),
    );
    debugPrint('Error in ${bloc.runtimeType}: $error');
  }

  @override
  void onClose(BlocSignalBase bloc) {
    super.onClose(bloc);
    unawaited(
      analyticsGateway?.logEvent(
        name: 'bloc_closed',
        parameters: {'bloc_name': bloc.runtimeType.toString()},
      ),
    );
    debugPrint('Container Closed: ${bloc.runtimeType}');
  }
}
