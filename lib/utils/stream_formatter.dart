import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class StreamFormatter {
  static dynamic fromDateTimeToJson(DateTime date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static DateTime toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }
      static StreamTransformer transformer<T>(T Function(Map<String, dynamic> json) fromJson) {
    return StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final users = snaps.map((json) => fromJson(json)).toList();

        sink.add(users);
      },
    );
  }

  static StreamTransformer transformer2<T>(T Function(Map<String, dynamic> json) fromJson) => StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json)).toList();

          sink.add(users);
        },
      );
}
