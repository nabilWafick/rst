import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';
import 'package:rst/modules/cash/settlements/services/settlements.service.dart';

class SettlementsController {
  static Future<ControllerResponse> create({
    required Settlement settlement,
  }) async {
    final serviceResponse = await SettlementsServices.create(
      settlement: settlement,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> createMultiple({
    required List<Settlement> settlements,
  }) async {
    final serviceResponse = await SettlementsServices.createMultiple(
      settlements: settlements,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int settlementId,
  }) async {
    final serviceResponse = await SettlementsServices.getOne(
      settlementId: settlementId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
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
    final serviceResponse = await SettlementsServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll() async {
    final serviceResponse = await SettlementsServices.countAll();

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
    final serviceResponse = await SettlementsServices.countSpecific(
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

  static Future<ControllerResponse> sumOfNumberForCard({
    required int cardId,
  }) async {
    final serviceResponse = await SettlementsServices.sumOfNomberForCard(
      cardId: cardId,
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
    required int settlementId,
    required Settlement settlement,
  }) async {
    final serviceResponse = await SettlementsServices.update(
      settlementId: settlementId,
      settlement: settlement,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> increase({
    required int settlementId,
    required Map<String, double> amount,
  }) async {
    final serviceResponse = await SettlementsServices.increase(
      settlementId: settlementId,
      amount: amount,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> decrease({
    required int settlementId,
    required Map<String, double> amount,
  }) async {
    final serviceResponse = await SettlementsServices.decrease(
      settlementId: settlementId,
      amount: amount,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int settlementId,
  }) async {
    final serviceResponse = await SettlementsServices.delete(
      settlementId: settlementId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (settlementMap) => Settlement.fromMap(
              settlementMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
