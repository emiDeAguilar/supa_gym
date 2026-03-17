import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supa_routines/main.dart';


class AuthService {
  Future<void> signIn(String email) async {
    await supabase.auth.signInWithOtp(
      email: email.trim(),
      emailRedirectTo:
          kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
    );
  }

  Stream<AuthState> authChanges() {
    return supabase.auth.onAuthStateChange;
  }
}