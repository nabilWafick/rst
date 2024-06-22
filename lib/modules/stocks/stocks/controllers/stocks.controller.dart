import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/stocks/stocks/models/stock/stock.model.dart';
import 'package:rst/modules/stocks/stocks/services/stocks.service.dart';

class StocksController {
  static Future<ControllerResponse> createManualInput({
    required Stock stock,
  }) async {
    final serviceResponse = await StocksServices.createManualInput(
      stock: stock,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> createManualOutput({
    required Stock stock,
  }) async {
    final serviceResponse = await StocksServices.createManualOutput(
      stock: stock,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int stockId,
  }) async {
    final serviceResponse = await StocksServices.getOne(
      stockId: stockId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
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
    final serviceResponse = await StocksServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll() async {
    final serviceResponse = await StocksServices.countAll();

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
    final serviceResponse = await StocksServices.countSpecific(
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

  static Future<ControllerResponse> updateManualInput({
    required int stockId,
    required Stock stock,
  }) async {
    final serviceResponse = await StocksServices.updateManualInput(
      stockId: stockId,
      stock: stock,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> updateManualOutput({
    required int stockId,
    required Stock stock,
  }) async {
    final serviceResponse = await StocksServices.updateManualOutput(
      stockId: stockId,
      stock: stock,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> checkCardProductAvailability({
    required int cardId,
  }) async {
    final serviceResponse = await StocksServices.checkCardProductAvailability(
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

  static Future<ControllerResponse> delete({
    required int stockId,
  }) async {
    final serviceResponse = await StocksServices.delete(
      stockId: stockId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (stockMap) => Stock.fromMap(
              stockMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
