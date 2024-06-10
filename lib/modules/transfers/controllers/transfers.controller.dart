import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/transfers/models/transfer/transfer.model.dart';
import 'package:rst/modules/transfers/services/transfers.service.dart';

class TransfersController {
  static Future<ControllerResponse> create({
    required Transfer transfer,
  }) async {
    final serviceResponse = await TransfersServices.create(
      transfer: transfer,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (transferMap) => Transfer.fromMap(
              transferMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int transferId,
  }) async {
    final serviceResponse = await TransfersServices.getOne(
      transferId: transferId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (transferMap) => Transfer.fromMap(
              transferMap,
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
    final serviceResponse = await TransfersServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (transferMap) => Transfer.fromMap(
              transferMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll() async {
    final serviceResponse = await TransfersServices.countAll();

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
    final serviceResponse = await TransfersServices.countSpecific(
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
    required int transferId,
    required Transfer transfer,
  }) async {
    final serviceResponse = await TransfersServices.update(
      transferId: transferId,
      transfer: transfer,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (transferMap) => Transfer.fromMap(
              transferMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int transferId,
  }) async {
    final serviceResponse = await TransfersServices.delete(
      transferId: transferId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (transferMap) => Transfer.fromMap(
              transferMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
