import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchProvider = StateProvider.family<String, String>((ref, name) {
  return '';
});

final isSearchingProvider = StateProvider.family<bool, String>((ref, name) {
  return false;
});
