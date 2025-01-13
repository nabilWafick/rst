import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';
import 'package:rst/modules/definitions/personal_status/services/personal_status.service.dart';

class PersonalStatusController {
  static Future<ControllerResponse> create({
    required PersonalStatus personalStatus,
  }) async {
    final serviceResponse = await PersonalStatusServices.create(
      personalStatus: personalStatus,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (personalStatusMap) => PersonalStatus.fromMap(
              personalStatusMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int personalStatusId,
  }) async {
    final serviceResponse = await PersonalStatusServices.getOne(
      personalStatusId: personalStatusId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (personalStatusMap) => PersonalStatus.fromMap(
              personalStatusMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getMany({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await PersonalStatusServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (personalStatusMap) => PersonalStatus.fromMap(
              personalStatusMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll({
    Map<String, dynamic>? listParameters,
  }) async {
    final serviceResponse = await PersonalStatusServices.countAll(listParameters: listParameters);

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countSpecific({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await PersonalStatusServices.countSpecific(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> update({
    required int personalStatusId,
    required PersonalStatus personalStatus,
  }) async {
    final serviceResponse = await PersonalStatusServices.update(
      personalStatusId: personalStatusId,
      personalStatus: personalStatus,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (personalStatusMap) => PersonalStatus.fromMap(
              personalStatusMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int personalStatusId,
  }) async {
    final serviceResponse = await PersonalStatusServices.delete(
      personalStatusId: personalStatusId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (personalStatusMap) => PersonalStatus.fromMap(
              personalStatusMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
