import 'dart:async';
import 'dart:developer';

void consoleLog(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  Zone? zone,
  Object? error,
  StackTrace? stackTrace,
}) {
  log(
    message,
    time: time,
    sequenceNumber: sequenceNumber,
    level: level,
    name: "LIBRARY_APP",
    zone: zone,
    error: error,
    stackTrace: stackTrace,
  );
}
