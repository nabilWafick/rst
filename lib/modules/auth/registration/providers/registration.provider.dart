import 'package:flutter_riverpod/flutter_riverpod.dart';

// used for storing agent email (form)
final newUserEmailProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent email (form)
final newUserPasswordProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);
