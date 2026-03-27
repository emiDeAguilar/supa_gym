import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supa_routines/data/user_provider.dart';

class UserdataProvider extends ConsumerWidget {
  final String Function(Map<String, dynamic> user) dataBuilder;
  final String errorText;

  const UserdataProvider({
    super.key,
    required this.dataBuilder,
    this.errorText = "Error",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return userAsync.when(
      data: (user) => Text(dataBuilder(user)),
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => Text(errorText),
    );
  }
}

// userAsync.when(
//   data: (user) => Text("Welcome back, ${user['username']}"),
//   loading: () => const CircularProgressIndicator(),
//   error: (e, _) => const Text("Error loading user"),
// ),