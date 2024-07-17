import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../auth/firebase_auth/auth_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

const kMaxEventNameLength = 40;
const kMaxParameterLength = 100;

void logFirebaseEvent(String eventName, {Map<String, Object>? parameters}) {
  // https://firebase.google.com/docs/reference/cpp/group/event-names
  assert(eventName.length <= kMaxEventNameLength, 'Event name exceeds max length of $kMaxEventNameLength characters');

  // Ensure the `user` parameter is included
  final updatedParameters = parameters ?? {};
  updatedParameters.putIfAbsent(
    'user', 
    () => currentUserUid.isEmpty ? 'unset' : currentUserUid,
  );

  // Remove null or invalid parameters
  updatedParameters.removeWhere((k, v) => k == null || v == null);

  // Ensure parameter values are strings and within length limits
  final params = updatedParameters.map((k, v) {
    if (v is! num) {
      var valStr = v.toString();
      if (valStr.length > kMaxParameterLength) {
        valStr = valStr.substring(0, kMaxParameterLength);
      }
      return MapEntry(k, valStr);
    }
    return MapEntry(k, v);
  });

  FirebaseAnalytics.instance.logEvent(
    name: eventName,
    parameters: params,
  );
}

void logFirebaseAuthEvent(User? user, String method) {
  if (user == null) return;  // Handle the case where the user is null

  final isSignup = user.metadata.creationTime == user.metadata.lastSignInTime;
  final authEvent = isSignup ? 'sign_up' : 'login';
  logFirebaseEvent(authEvent, parameters: {'method': method});
}
