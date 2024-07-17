import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB-TVFWD1FwcydzKQiFpUaIdYauApYrMZQ",
            authDomain: "migouabo-v2.firebaseapp.com",
            projectId: "migouabo-v2",
            storageBucket: "migouabo-v2.appspot.com",
            messagingSenderId: "812333974524",
            appId: "1:812333974524:web:2f9d88e64eecdc78416879",
            measurementId: "G-0BNQTFBKV5"));
  } else {
    await Firebase.initializeApp();
  }
}
