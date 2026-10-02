/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i2;
import '../appearance/appearance_endpoint.dart' as _i3;
import '../greetings/greeting_endpoint.dart' as _i4;
import '../auth/email_idp_endpoint.dart' as _i5;
import '../auth/jwt_refresh_endpoint.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'appearance': _i3.AppearanceEndpoint()
        ..initialize(
          server,
          'appearance',
          null,
        ),
      'greeting': _i4.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'emailIdp': _i5.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i6.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
    };

    connectors['appearance'] = _i1.EndpointConnector(
      name: 'appearance',
      endpoint: endpoints['appearance']!,
      methodConnectors: {
        'getSettings': _i1.MethodConnector(
          name: 'getSettings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['appearance'] as _i3.AppearanceEndpoint)
                  .getSettings(session),
        ),
        'updateSettings': _i1.MethodConnector(
          name: 'updateSettings',
          params: {
            'themeMode': _i1.ParameterDescription(
              name: 'themeMode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'seedColor': _i1.ParameterDescription(
              name: 'seedColor',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'locale': _i1.ParameterDescription(
              name: 'locale',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['appearance'] as _i3.AppearanceEndpoint).updateSettings(
            session,
            params['themeMode'],
            params['seedColor'],
            params['locale'],
          ),
        ),
      },
    );

    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['greeting'] as _i4.GreetingEndpoint).hello(
            session,
            params['name'],
          ),
        ),
      },
    );

    modules['serverpod_auth_idp'] = _i2.Endpoints()
      ..initializeEndpoints(server);
  }
}
