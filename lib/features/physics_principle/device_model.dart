import 'package:flutter/material.dart';

class Device {
  final String id;
  final String emoji;
  final String name;
  final String arabic;
  final Color color;

  const Device({
    required this.id,
    required this.emoji,
    required this.name,
    required this.arabic,
    required this.color,
  });
}