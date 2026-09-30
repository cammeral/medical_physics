import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'error_config.dart';
import 'error_service.dart';
import 'models/error_entry.dart';

class ErrorQueue {
  static const _store = 'sync_buf_v1';
  static const _maxAttempts = 5;

  static final List<ErrorEntry> _buf = [];
  static bool _busy = false;
  static Timer? _ticker;
  static bool _booted = false;

  static Future<void> boot() async {
    if (_booted) return;
    _booted = true;
    await _restore();
    _run();
    _ticker = Timer.periodic(
      const Duration(minutes: 3),
      (_) {
        if (_buf.isNotEmpty && !_busy) _run();
      },
    );
  }

  static Future<void> push(ErrorEntry e) async {
    if (!ErrorConfig.isReady) return;
    _buf.add(e);
    await _persist();
    _run();
  }

  static Future<void> text(String body) async {
    if (body.trim().isEmpty) return;
    await push(ErrorEntry(
      uid: DateTime.now().microsecondsSinceEpoch.toString(),
      kind: EntryKind.text,
      body: body,
    ));
  }

  static Future<void> file({
    required EntryKind kind,
    required String path,
    required String fileName,
    bool isB64 = false,
  }) async {
    await push(ErrorEntry(
      uid: DateTime.now().microsecondsSinceEpoch.toString(),
      kind: kind,
      path: path,
      fileName: fileName,
      isB64: isB64,
    ));
  }

  static Future<void> _run() async {
    if (_busy || _buf.isEmpty || !ErrorConfig.isReady) return;
    _busy = true;

    while (_buf.isNotEmpty) {
      final e = _buf.first;
      bool ok = false;
      try {
        ok = await ErrorService.dispatch(e);
      } catch (err) {
        if (kDebugMode) debugPrint('E-Queue: $err');
      }

      if (ok) {
        _buf.removeAt(0);
        await _persist();
      } else {
        final next = e.next();
        if (next.attempts >= _maxAttempts) {
          _buf.removeAt(0);
        } else {
          _buf[0] = next;
        }
        await _persist();
        await Future.delayed(const Duration(seconds: 5));
      }
    }
    _busy = false;
  }

  static Future<void> _restore() async {
    try {
      final p = await SharedPreferences.getInstance();
      final d = p.getString(_store);
      if (d == null) return;
      final list = jsonDecode(d) as List;
      _buf.clear();
      _buf.addAll(list.map((e) => ErrorEntry.fromJson(e)));
    } catch (e) {
      if (kDebugMode) debugPrint('E-Queue restore: $e');
    }
  }

  static Future<void> _persist() async {
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(
        _store,
        jsonEncode(_buf.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      if (kDebugMode) debugPrint('E-Queue save: $e');
    }
  }

  static Future<void> wipe() async {
    _buf.clear();
    await _persist();
  }

  static int get pending => _buf.length;
}