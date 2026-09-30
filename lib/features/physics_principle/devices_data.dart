import 'package:flutter/material.dart';
import 'device_model.dart';

const List<Device> devices = [
  Device(id: 'xray', emoji: '📷', name: 'X-ray',
      arabic: 'الأشعة السينية', color: Color(0xFF4A6CF7)),
  Device(id: 'ct', emoji: '🧠', name: 'CT Scan',
      arabic: 'التصوير المقطعي', color: Color(0xFF06B6A4)),
  Device(id: 'mri', emoji: '🧲', name: 'MRI',
      arabic: 'الرنين المغناطيسي', color: Color(0xFF9B5DE5)),
  Device(id: 'us', emoji: '🔊', name: 'Ultrasound',
      arabic: 'الموجات فوق الصوتية', color: Color(0xFFF4A261)),
  Device(id: 'pet', emoji: '☢️', name: 'PET',
      arabic: 'التصوير البوزيتروني', color: Color(0xFFE63946)),
  Device(id: 'spect', emoji: '🌟', name: 'SPECT',
      arabic: 'التصوير النووي', color: Color(0xFF10B981)),
  Device(id: 'rt', emoji: '💥', name: 'Radiotherapy',
      arabic: 'العلاج الإشعاعي', color: Color(0xFFEF4444)),
  Device(id: 'laser', emoji: '💡', name: 'Laser',
      arabic: 'العلاج بالليزر', color: Color(0xFFF59E0B)),
  Device(id: 'mammo', emoji: '🩻', name: 'Mammography',
      arabic: 'تصوير الثدي', color: Color(0xFF8B5CF6)),
  Device(id: 'fluoro', emoji: '📺', name: 'Fluoroscopy',
      arabic: 'التنظير التألقي', color: Color(0xFF0EA5E9)),
];