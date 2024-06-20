import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/auth/connection/models/connection.model.dart';
import 'package:rst/modules/auth/model/auth.model.dart';
import 'package:rst/modules/auth/registration/models/registration.model.dart';
import 'package:rst/modules/auth/services/auth.service.dart';

class AuthController {
  static Future<ControllerResponse> register({
    required AuthRegistration authRegistration,
  }) async {
    final serviceResponse = await AuthServices.register(
      authRegistration: authRegistration,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (authMap) => Auth.fromMap(
              authMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> connect({
    required AuthConnection authConnection,
  }) async {
    final serviceResponse = await AuthServices.connect(
      authConnection: authConnection,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (authMap) => Auth.fromMap(
              authMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> disconnect({
    required String userEmail,
  }) async {
    final serviceResponse = await AuthServices.disconnect(
      userEmail: userEmail,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (authMap) => Auth.fromMap(
              authMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
