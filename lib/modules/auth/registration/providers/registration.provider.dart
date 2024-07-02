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

// security questions
final securityQuestionsProvider = Provider<List<String>>((ref) {
  return [
    'Quel est votre prénom préféré',
    'Quel est votre couleur préférée',
    'Quel est le nom de votre ville de naissance',
    'Quelle est votre année de naissaince',
    'Quel est le nom de votre école primaire',
    'Quel est le nom votre pays de rêve',
    'Quelle est votre année de naissaince',
  ];
});

final newUserFirstSecurityQuestionAnswerProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final newUserSecondSecurityQuestionAnswerProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final newUserThirdSecurityQuestionAnswerProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);
