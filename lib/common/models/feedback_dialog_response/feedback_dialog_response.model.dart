// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FeedbackDialogResponse {
  final String? result;
  final String? error;
  final String message;
  FeedbackDialogResponse({
    this.result,
    this.error,
    required this.message,
  });

  FeedbackDialogResponse copyWith({
    String? result,
    String? error,
    String? message,
  }) {
    return FeedbackDialogResponse(
      result: result ?? this.result,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': result,
      'error': error,
      'message': message,
    };
  }

  factory FeedbackDialogResponse.fromMap(Map<String, dynamic> map) {
    return FeedbackDialogResponse(
      result: map['result'] != null ? map['result'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackDialogResponse.fromJson(String source) =>
      FeedbackDialogResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FeedbackDialogResponse(result: $result, error: $error, message: $message)';

  @override
  bool operator ==(covariant FeedbackDialogResponse other) {
    if (identical(this, other)) return true;

    return other.result == result &&
        other.error == error &&
        other.message == message;
  }

  @override
  int get hashCode => result.hashCode ^ error.hashCode ^ message.hashCode;
}
