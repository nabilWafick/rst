import 'package:rst/common/models/common.model.dart';

class ControllerResponse extends ServiceResponse {
  ControllerResponse({
    required super.statusCode,
    required super.data,
    super.result,
    super.error,
    super.message,
  });
}
