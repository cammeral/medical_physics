import 'package:flutter/foundation.dart';

/// ValueNotifier يُستخدم لإعلام الصفحة الرئيسية عند تغيير الجدول
final ValueNotifier<int> scheduleVersion = ValueNotifier<int>(0);

void bumpScheduleVersion() {
  scheduleVersion.value++;
}