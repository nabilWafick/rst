import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';

// will be used for getting search input value
final searchProvider = StateProvider.family<String, String>((ref, name) {
  return '';
});

/*
final isSearchingProvider = StateProvider.family<bool, String>((ref, name) {
  return false;
});
*/

final feedbackDialogResponseProvider =
    StateProvider<FeedbackDialogResponse>((ref) {
  return FeedbackDialogResponse(message: 'Hello RST User');
});
