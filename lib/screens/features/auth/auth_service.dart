import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async{
  return await _supabase.auth.signInWithPassword(password: password, email: email);
  }

  Future<AuthResponse> signUpWithPassword(String email, String password) async{
    return await _supabase.auth.signUp(password: password, email: email);
  }

  Future<void> signOut() async{
    await _supabase.auth.signOut();
  }

  String? getCurrentUserEmail(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  String? getCurrentUserId(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

 Future<PostgrestMap?> userSelect(String authId)async{
   final data = await _supabase
        .from('users')
        .select('username, gender, birth_date')
        .eq('id', authId)
        .maybeSingle();
      return data;
 }
}