import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/categories/controllers/categories.controller.dart';
import 'package:rst/modules/definitions/categories/models/category/category.model.dart';

// used for storing category name (form)
final categoryNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing categories filter options
final categoriesListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing added filter tool
final categoriesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched categories
final categoriesListStreamProvider =
    FutureProvider<List<Category>>((ref) async {
  final listParameters = ref.watch(categoriesListParametersProvider);

  final controllerResponse = await CategoriesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Category>.from(controllerResponse.data)
      : <Category>[];
});

// used for storing all categories of database count
final categoriesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CategoriesController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched categories (categories respecting filter options) count
final specificCategoriesCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(categoriesListParametersProvider);

  final controllerResponse = await CategoriesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
