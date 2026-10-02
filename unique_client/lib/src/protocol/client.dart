/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i2;

import 'appearance/user_appearance_settings.dart' as _i3;
import 'greetings/greeting.dart' as _i4;

export 'appearance/user_appearance_settings.dart';
export 'greetings/greeting.dart';

class EndpointAppearance extends _i1.EndpointRef {
  EndpointAppearance(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'appearance';

  _i1.Future<_i3.UserAppearanceSettings?> getSettings() =>
      caller.callServerEndpoint<_i3.UserAppearanceSettings?>(
        'appearance',
        'getSettings',
        {},
      );

  _i1.Future<_i3.UserAppearanceSettings> updateSettings(
    String themeMode,
    int seedColor,
    String locale,
  ) =>
      caller.callServerEndpoint<_i3.UserAppearanceSettings>(
        'appearance',
        'updateSettings',
        {
          'themeMode': themeMode,
          'seedColor': seedColor,
          'locale': locale,
        },
      );
}

class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  _i1.Future<_i4.Greeting> hello(String name) => caller.callServerEndpoint<_i4.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectOnSessionEnded,
  }) : super(
          host,
          Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectOnSessionEnded: disconnectOnSessionEnded,
        ) {
    appearance = EndpointAppearance(this);
    greeting = EndpointGreeting(this);
    emailIdp = _i2.Caller(this);
    jwtRefresh = _i2.Caller(this);
  }

  late final EndpointAppearance appearance;

  late final EndpointGreeting greeting;

  late final _i2.Caller emailIdp;

  late final _i2.Caller jwtRefresh;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'appearance': appearance,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
        'serverpod_auth_idp': emailIdp,
      };
}
