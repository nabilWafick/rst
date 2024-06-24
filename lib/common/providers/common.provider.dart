import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';

final feedbackDialogResponseProvider =
    StateProvider<FeedbackDialogResponse>((ref) {
  return FeedbackDialogResponse(message: 'Hello RST User');
});

final permissionsProvider = Provider<Map<String, dynamic>>((ref) {
  return {
    'admin': false,
    'add-product': false,
    'update-product': false,
    'delete-product': false,
    'add-type': false,
    'update-type': false,
    'delete-type': false,
    'add-category': false,
    'update-categry': false,
    'delete-category': false,
    'add-locality': false,
    'update-locality': false,
    'delete-locality': false,
    'add-personal-status': false,
    'update-personal-status': false,
    'delete-personal-status': false,
    'add-economical-activity': false,
    'update-economical-activity': false,
    'delete-economical-activity': false,
    'add-card': false,
    'update-card': false,
    'delete-card': false,
    'add-customer': false,
    'update-customer': false,
    'delete-customer': false,
    'add-collector': false,
    'update-collector': false,
    'delete-collector': false,
    'add-agent': false,
    'update-agent': false,
    'delete-agent': false,
    'add-settlement': false,
    'update-settlement': false,
    'delete-settlement': false,
  };
});
