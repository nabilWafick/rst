import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/services/cards.service.dart';

class CardsController {
  static Future<ControllerResponse> create({
    required Card card,
  }) async {
    final serviceResponse = await CardsServices.create(
      card: card,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (cardMap) => Card.fromMap(
              cardMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int cardId,
  }) async {
    final serviceResponse = await CardsServices.getOne(
      cardId: cardId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (cardMap) => Card.fromMap(
              cardMap,
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
    final serviceResponse = await CardsServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (cardMap) => Card.fromMap(
              cardMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll() async {
    final serviceResponse = await CardsServices.countAll();

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
    final serviceResponse = await CardsServices.countSpecific(
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
    required int cardId,
    required Card card,
  }) async {
    final serviceResponse = await CardsServices.update(
      cardId: cardId,
      card: card,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (cardMap) => Card.fromMap(
              cardMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int cardId,
  }) async {
    final serviceResponse = await CardsServices.delete(
      cardId: cardId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (cardMap) => Card.fromMap(
              cardMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
