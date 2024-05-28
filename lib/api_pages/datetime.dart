import 'package:flutter/material.dart';
String getDate() {
  DateTime now = DateTime.now();
  return "${now.day}/${now.month}/${now.year}";
}
String getTime() {
  DateTime now = DateTime.now();
  String period = now.hour < 12 ? 'AM' : 'PM';
  int hour = now.hour > 12 ? now.hour - 12 : now.hour;
  String minute = now.minute.toString().padLeft(2, '0');
  return "$hour:$minute $period";
}