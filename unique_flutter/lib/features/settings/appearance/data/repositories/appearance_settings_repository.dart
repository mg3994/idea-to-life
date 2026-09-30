// ignore: depend_on_referenced_packages
import 'package:signals_core/signals_core.dart';

import 'dart:async' show unawaited;

import '../../../../../app/di/app_dependencies.dart' show AppDependencies;
import '../../../../../core/core.dart'
    show AppearanceSettingsState, AppearanceSettingsStateX;
import '../../domain/repositories/appearance_settings_repository.dart'
    show AppearanceSettingsRepository;

/// Concrete implementation of [AppearanceSettingsRepository] managing
/// offline-first reactivity and cloud synchronization.
class AppearanceSettingsRepositoryImpl({
  required AppDependencies appDependencies,
  required Stream<AppearanceSettingsState> cloudStream,
  required Stream<AppearanceSettingsState> localStream,
  required Stream<bool> isConnectedStream,
  required final Future<void> Function(AppearanceSettingsState settings)
  updateRemoteSettings,
  required final Future<void> Function(AppearanceSettingsState settings)
  updateLocalSettings,
}) implements AppearanceSettingsRepository {
  // Reactive State Signals
  final _settingsSignal = signal<AppearanceSettingsState>(
    AppearanceSettingsStateX.initial(appDependencies.flavorConfig),
  );
  final _isConnectedSignal = signal(true);

  // Status Signals
  final _syncError = signal<String?>(null);
  final _isPendingSync = signal<bool>(false);
  final _isSyncing = signal<bool>(false); // Guards against re-entrancy / loops

  // Callback bindings
  final Future<void> Function(AppearanceSettingsState settings)
  _updateRemoteSettings = updateRemoteSettings;
  final Future<void> Function(AppearanceSettingsState settings)
  _updateLocalSettings = updateLocalSettings;

  // Stream Connectors & Effects
  late final Connect<AppearanceSettingsState, AppearanceSettingsState>
  _connector;
  late final Connect<bool, bool> _connectivityConnector;
  EffectCleanup? _reconnectEffectCleanup;

  // Primary Constructor Body
  this {
    // 1. Bind connectivity stream to signal
    _connectivityConnector = connect(_isConnectedSignal)
      ..from(isConnectedStream);

    // 2. Setup reactive stream mapping for Local and Cloud sources
    final autoClearingCloudStream = cloudStream.map((data) {
      _syncError.value = null;
      _reconcileIncomingCloudData(data);
      return data;
    });

    final autoClearingLocalStream = localStream.map((data) {
      _syncError.value = null;
      _reconcileIncomingLocalData(data);
      return data;
    });

    _connector = connect(_settingsSignal)
      ..from(autoClearingCloudStream)
      ..from(autoClearingLocalStream);

    // 3. Auto-reconnect Listener: Automatically pushes pending local changes when online
    _reconnectEffectCleanup = effect(() {
      final isConnected = _isConnectedSignal.value;
      final isPending = _isPendingSync.value;
      final isSyncing = _isSyncing.value;

      if (isConnected && isPending && !isSyncing) {
        unawaited(_pushPendingToRemote());
      }
    });
  }

  @override
  ReadonlySignal<AppearanceSettingsState> get computedAppearanceSettings =>
      _settingsSignal;

  @override
  ReadonlySignal<String?> get syncError => _syncError;

  @override
  ReadonlySignal<bool> get isPendingSync => _isPendingSync;

  @override
  void clearError() {
    _syncError.value = null;
  }

  /// Mutates settings state optimistically and triggers sync pipelines.
  @override
  Future<void> updateSettings(AppearanceSettingsState newSettings) async {
    final currentSettings = _settingsSignal.value;

    // Prevent redundant work if no values changed
    if (currentSettings == newSettings) return;

    // Stamp state with UTC timestamp for conflict reconciliation
    final stampedSettings = newSettings.copyWith(
      updatedAt: DateTime.now().toUtc(),
    );

    // 0ms Optimistic UI Update
    batch(() {
      _syncError.value = null;
      _settingsSignal.value = stampedSettings;
    });

    // Always persist to local DB immediately
    await _updateLocalSettings(stampedSettings);

    // Push to remote if online, otherwise flag as pending
    if (_isConnectedSignal.value) {
      await _pushPendingToRemote();
    } else {
      _isPendingSync.value = true;
    }
  }

  /// Core Sync Worker: Safely pushes current local state to Remote API.
  Future<void> _pushPendingToRemote() async {
    if (_isSyncing.value) return;
    _isSyncing.value = true;

    try {
      final currentLocal = _settingsSignal.value;
      await _updateRemoteSettings(currentLocal);

      batch(() {
        _isPendingSync.value = false;
        _syncError.value = null;
      });
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      batch(() {
        _isPendingSync.value = true;
        _syncError.value = 'Saved locally. Will sync when back online.';
      });
    } finally {
      _isSyncing.value = false;
    }
  }

  /// Cloud Conflict Resolution Pipeline
  void _reconcileIncomingCloudData(AppearanceSettingsState cloudState) {
    final currentLocal = _settingsSignal.value;

    // Case 1: Match/Equal timestamps -> Synchronization achieved, clear pending flag
    if (cloudState == currentLocal ||
        cloudState.updatedAt == currentLocal.updatedAt) {
      _isPendingSync.value = false;
      return;
    }

    // Case 2: Unsynced local changes exist AND local is newer -> Push local to cloud
    if (_isPendingSync.value &&
        currentLocal.updatedAt.isAfter(cloudState.updatedAt)) {
      if (_isConnectedSignal.value) {
        unawaited(_pushPendingToRemote());
      }
      return;
    }

    // Case 3: Cloud state is newer -> Overwrite local state & DB with cloud data
    if (cloudState.updatedAt.isAfter(currentLocal.updatedAt)) {
      batch(() {
        _settingsSignal.value = cloudState;
        _isPendingSync.value = false; // Prevents loop and clears pending status
      });
      unawaited(_updateLocalSettings(cloudState));
    }
  }

  /// Local DB Conflict Resolution Pipeline
  void _reconcileIncomingLocalData(AppearanceSettingsState localState) {
    final current = _settingsSignal.value;

    if (localState.updatedAt.isAfter(current.updatedAt)) {
      _settingsSignal.value = localState;
    }
  }

  @override
  void dispose() {
    _reconnectEffectCleanup?.call();
    _connector.dispose();
    _connectivityConnector.dispose();
    _settingsSignal.dispose();
    _isConnectedSignal.dispose();
    _syncError.dispose();
    _isPendingSync.dispose();
    _isSyncing.dispose();
  }
}
