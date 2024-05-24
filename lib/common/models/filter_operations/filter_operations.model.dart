import 'package:rst/common/models/operator/operator.model.dart';

class FilterOperators {
  static final List<Operator> commonOperators = [
    Operator(
      front: 'égal à',
      back: 'equals',
    ),
    Operator(
      front: 'différent de',
      back: 'not',
    ),
  ];
  static final List<Operator> stringOperators = [
    Operator(
      front: 'contenant',
      back: 'contains',
    ),
    Operator(
      front: 'commençant par',
      back: 'startsWith',
    ),
    Operator(
      front: 'finissant par',
      back: 'endsWith',
    ),
  ];
  static final List<Operator> numberOperators = [
    Operator(
      front: 'inférieur à',
      back: 'lt',
    ),
    Operator(
      front: 'inférieur ou égal à',
      back: 'lte',
    ),
    Operator(
      front: 'supérieur à',
      back: 'gt',
    ),
    Operator(
      front: 'supérieur ou égal à',
      back: 'gte',
    ),
  ];
  static final List<Operator> datesOperators = [
    Operator(
      front: 'inférieur à',
      back: 'lt',
    ),
    Operator(
      front: 'inférieur ou égal à',
      back: 'lte',
    ),
    Operator(
      front: 'supérieur à',
      back: 'gt',
    ),
    Operator(
      front: 'supérieur ou égal à',
      back: 'gte',
    ),
  ];

  static final List<Operator> allOperators = [
    ...commonOperators,
    ...stringOperators,
    ...numberOperators,
    ...datesOperators,
  ];
}
