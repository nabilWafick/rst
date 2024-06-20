import 'package:flutter_riverpod/flutter_riverpod.dart';

// used for storing agent email (form)
final userEmailProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent email (form)
final userPasswordProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);
