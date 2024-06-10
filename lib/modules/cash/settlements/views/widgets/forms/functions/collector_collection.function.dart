import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/modules/cash/collections/controllers/collections.controller.dart';
import 'package:rst/modules/cash/collections/models/collection/collection.model.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';

void collectionOfCollectorOf({
  required WidgetRef ref,
  required Collector collector,
  required DateTime dateTime,
}) {
  try {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () async {
        final searchDate = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          0,
          0,
          0,
        );

        final collectionsData =
            await CollectionsController.getMany(listParameters: {
          'skip': 0,
          'take': 4,
          'where': {
            'AND': [
              {
                'collectorId': collector.id,
              },
              {
                'collectedAt': {
                  'gte': FunctionsController.getTimestamptzDateString(
                    dateTime: searchDate,
                  ),
                  'lt': FunctionsController.getTimestamptzDateString(
                    dateTime: searchDate.add(
                      const Duration(
                        hours: 23,
                        minutes: 59,
                        seconds: 59,
                      ),
                    ),
                  )
                }
              }
            ]
          }
        });

        final List<Collection> collections =
            List<Collection>.from(collectionsData.data);
        ref.read(settlementCollectorCollectionProvider.notifier).state =
            collections.isNotEmpty ? collections.first : null;
      },
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}
