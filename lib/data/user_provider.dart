import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = FutureProvider((ref) async {
  final supabase = Supabase.instance.client;
  final userId = supabase.auth.currentUser!.id;

  final data = await supabase
      .from('users')
      .select()
      .eq('id', userId)
      .single();

  return data;
});

