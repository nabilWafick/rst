import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/economical_activities/models/economical_activities.model.dart';
import 'package:rst/modules/definitions/economical_activities/services/economical_activities.service.dart';

class EconomicalActivitiesController {
  static Future<ControllerResponse> create({
    required EconomicalActivity economicalActivity,
  }) async {
    final serviceResponse = await EconomicalActivitiesServices.create(
      economicalActivity: economicalActivity,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (economicalActivityMap) => EconomicalActivity.fromMap(
              economicalActivityMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int economicalActivityId,
  }) async {
    final serviceResponse = await EconomicalActivitiesServices.getOne(
      economicalActivityId: economicalActivityId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (economicalActivityMap) => EconomicalActivity.fromMap(
              economicalActivityMap,
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
    final serviceResponse = await EconomicalActivitiesServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (economicalActivityMap) => EconomicalActivity.fromMap(
              economicalActivityMap,
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
    final serviceResponse =
        await EconomicalActivitiesServices.countAll(listParameters: listParameters);

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
    final serviceResponse = await EconomicalActivitiesServices.countSpecific(
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
    required int economicalActivityId,
    required EconomicalActivity economicalActivity,
  }) async {
    final serviceResponse = await EconomicalActivitiesServices.update(
      economicalActivityId: economicalActivityId,
      economicalActivity: economicalActivity,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (economicalActivityMap) => EconomicalActivity.fromMap(
              economicalActivityMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int economicalActivityId,
  }) async {
    final serviceResponse = await EconomicalActivitiesServices.delete(
      economicalActivityId: economicalActivityId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (economicalActivityMap) => EconomicalActivity.fromMap(
              economicalActivityMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
