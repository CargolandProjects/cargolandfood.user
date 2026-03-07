import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stackfood_multivendor/helper/route_helper.dart';

enum AppPopupType { push, promo }

class PopupManager {
  static final Queue<_PopupTask> _pushQueue = Queue<_PopupTask>();
  static final Queue<_PopupTask> _promoQueue = Queue<_PopupTask>();
  static final Set<String> _pendingDedupeKeys = <String>{};

  static bool _isProcessing = false;
  static bool _isShowingManagedDialog = false;
  static Timer? _retryTimer;
  static DateTime? _lastPushShownAt;

  static const Duration _promoCooldownAfterPush = Duration(seconds: 20);
  static const Duration _defaultRetryDelay = Duration(seconds: 2);

  static const List<String> _promoBlockedRoutes = <String>[
    RouteHelper.splash,
    RouteHelper.checkout,
    RouteHelper.payment,
    RouteHelper.orderTracking,
    RouteHelper.messages,
    RouteHelper.conversation,
  ];

  static void enqueuePushDialog({
    required Widget dialog,
    bool barrierDismissible = true,
    String? dedupeKey,
    FutureOr<void> Function(dynamic result)? onResult,
  }) {
    _enqueue(
      _PopupTask(
        type: AppPopupType.push,
        dialog: dialog,
        barrierDismissible: barrierDismissible,
        dedupeKey: dedupeKey,
        onResult: onResult,
      ),
    );
  }

  static void enqueuePromoDialog({
    required Widget dialog,
    bool barrierDismissible = true,
    String? dedupeKey,
    FutureOr<void> Function(dynamic result)? onResult,
  }) {
    _enqueue(
      _PopupTask(
        type: AppPopupType.promo,
        dialog: dialog,
        barrierDismissible: barrierDismissible,
        dedupeKey: dedupeKey,
        onResult: onResult,
      ),
    );
  }

  static void _enqueue(_PopupTask task) {
    if (task.dedupeKey != null && _pendingDedupeKeys.contains(task.dedupeKey)) {
      return;
    }
    if (task.dedupeKey != null) {
      _pendingDedupeKeys.add(task.dedupeKey!);
    }

    if (task.type == AppPopupType.push) {
      _pushQueue.add(task);
    } else {
      _promoQueue.add(task);
    }

    _scheduleProcess();
  }

  static void _scheduleProcess([Duration delay = Duration.zero]) {
    _retryTimer?.cancel();
    _retryTimer = Timer(delay, _processQueue);
  }

  static Future<void> _processQueue() async {
    if (_isProcessing) {
      return;
    }
    _isProcessing = true;

    try {
      while (true) {
        if ((Get.isDialogOpen ?? false) && !_isShowingManagedDialog) {
          _scheduleProcess(const Duration(milliseconds: 800));
          return;
        }

        final _PopupTask? task = _nextTask();
        if (task == null) {
          return;
        }

        if (Get.context == null && Get.overlayContext == null) {
          _requeueFront(task);
          _scheduleProcess(_defaultRetryDelay);
          return;
        }

        dynamic result;
        _isShowingManagedDialog = true;
        try {
          result = await Get.dialog<dynamic>(
            task.dialog,
            barrierDismissible: task.barrierDismissible,
            useSafeArea: true,
          );
        } catch (_) {
          _requeueFront(task);
          _scheduleProcess(_defaultRetryDelay);
          return;
        } finally {
          _isShowingManagedDialog = false;
        }

        if (task.type == AppPopupType.push) {
          _lastPushShownAt = DateTime.now();
        }

        _consumeDedupe(task);
        if (task.onResult != null) {
          try {
            await task.onResult!(result);
          } catch (_) {}
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  static _PopupTask? _nextTask() {
    if (_pushQueue.isNotEmpty) {
      return _pushQueue.removeFirst();
    }

    if (_promoQueue.isEmpty) {
      return null;
    }

    if (!_canShowPromoNow()) {
      _scheduleProcess(_promoRetryDelay());
      return null;
    }

    return _promoQueue.removeFirst();
  }

  static bool _canShowPromoNow() {
    if (_pushQueue.isNotEmpty) {
      return false;
    }

    if (_lastPushShownAt != null &&
        DateTime.now().difference(_lastPushShownAt!) < _promoCooldownAfterPush) {
      return false;
    }

    final String currentRoute = Get.currentRoute;
    for (final String blockedRoute in _promoBlockedRoutes) {
      if (currentRoute.startsWith(blockedRoute)) {
        return false;
      }
    }

    return true;
  }

  static Duration _promoRetryDelay() {
    if (_lastPushShownAt != null) {
      final Duration elapsed = DateTime.now().difference(_lastPushShownAt!);
      if (elapsed < _promoCooldownAfterPush) {
        return _promoCooldownAfterPush - elapsed;
      }
    }
    return _defaultRetryDelay;
  }

  static void _requeueFront(_PopupTask task) {
    if (task.type == AppPopupType.push) {
      _pushQueue.addFirst(task);
    } else {
      _promoQueue.addFirst(task);
    }
  }

  static void _consumeDedupe(_PopupTask task) {
    if (task.dedupeKey != null) {
      _pendingDedupeKeys.remove(task.dedupeKey);
    }
  }
}

class _PopupTask {
  final AppPopupType type;
  final Widget dialog;
  final bool barrierDismissible;
  final String? dedupeKey;
  final FutureOr<void> Function(dynamic result)? onResult;

  _PopupTask({
    required this.type,
    required this.dialog,
    required this.barrierDismissible,
    required this.dedupeKey,
    required this.onResult,
  });
}
