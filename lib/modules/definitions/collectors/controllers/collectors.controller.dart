import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';
import 'package:rst/modules/definitions/collectors/services/collectors.service.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collector_collection/collector_collection.model.dart';

class CollectorsController {
  static Future<ControllerResponse> create({
    required Collector collector,
  }) async {
    final serviceResponse = await CollectorsServices.create(
      collector: collector,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => Collector.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int collectorId,
  }) async {
    final serviceResponse = await CollectorsServices.getOne(
      collectorId: collectorId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => Collector.fromMap(
              collectorMap,
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
    final serviceResponse = await CollectorsServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => Collector.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getGlobalCollections({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await CollectorsServices.getGlobalCollections(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => CollectorCollection.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getDayCollections({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await CollectorsServices.getDayCollections(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => CollectorCollection.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getWeekCollections({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await CollectorsServices.getWeekCollections(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => CollectorCollection.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getMonthCollections({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await CollectorsServices.getMonthCollections(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => CollectorCollection.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getYearCollections({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await CollectorsServices.getYearCollections(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => CollectorCollection.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll() async {
    final serviceResponse = await CollectorsServices.countAll();

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
    final serviceResponse = await CollectorsServices.countSpecific(
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
    required int collectorId,
    required Collector collector,
  }) async {
    final serviceResponse = await CollectorsServices.update(
      collectorId: collectorId,
      collector: collector,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => Collector.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int collectorId,
  }) async {
    final serviceResponse = await CollectorsServices.delete(
      collectorId: collectorId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (collectorMap) => Collector.fromMap(
              collectorMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
