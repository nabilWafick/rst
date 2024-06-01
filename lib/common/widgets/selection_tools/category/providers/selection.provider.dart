import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/categories/controllers/categories.controller.dart';
import 'package:rst/modules/definitions/categories/models/category/category.model.dart';

final categorySelectionToolProvider =
    StateProvider.family<Category?, String>((ref, toolName) {
  return;
});

// used for storing categories filter options
final categoriesSelectionListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched categories
final categoriesSelectionListStreamProvider =
    FutureProvider<List<Category>>((ref) async {
  final listParameters = ref.watch(categoriesSelectionListParametersProvider);

  final controllerResponse = await CategoriesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Category>.from(controllerResponse.data)
      : <Category>[];
});

// used for storing fetched categories (categories respecting filter options) count
final specificcategoriesSelectionCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref.watch(categoriesSelectionListParametersProvider);

  final controllerResponse = await CategoriesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
