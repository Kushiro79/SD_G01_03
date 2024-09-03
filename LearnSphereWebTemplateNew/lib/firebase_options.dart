import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: "AIzaSyCFhSWMK41QR4Q7ocf-BMuETakSgKJUVws",
        appId: "1:603404130009:web:5fd562b20af226586010c8",
        messagingSenderId: "603404130009",
        projectId: "learnsphere-e6563",
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: "AIzaSyCFhSWMK41QR4Q7ocf-BMuETakSgKJUVws",
        appId: "1:603404130009:web:5fd562b20af226586010c8",
        messagingSenderId: "603404130009",
        projectId: "learnsphere-e6563",
      );
    } else {
      // Android
      return const FirebaseOptions(
        apiKey: "AIzaSyCFhSWMK41QR4Q7ocf-BMuETakSgKJUVws",
        appId: "1:603404130009:web:5fd562b20af226586010c8",
        messagingSenderId: "603404130009",
        projectId: "learnsphere-e6563",
      );
    }
  }
}